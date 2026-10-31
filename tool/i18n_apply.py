#!/usr/bin/env python3
"""Envuelve los textos de la interfaz con tr('es', 'en') y quita los `const` que lo impiden."""
import glob
import re
import sys

sys.path.insert(0, 'tool')
from ui_en import UI  # noqa

FILES = sorted(glob.glob('lib/screens/*.dart') + glob.glob('lib/widgets/*.dart') + ['lib/main.dart'])
LIT = re.compile(r"(?<![A-Za-z_r$])'((?:[^'\\\n]|\\.)*)'")


def dart_q(s):
    return "'" + s.replace("'", "\\'") + "'"


def protected_spans(src):
    """Rangos dentro de llamadas tr(...) ya existentes."""
    spans = []
    for m in re.finditer(r'\btr\(', src):
        i, depth = m.end(), 1
        in_str = None
        while i < len(src) and depth:
            c = src[i]
            if in_str:
                if c == '\\':
                    i += 2
                    continue
                if c == in_str:
                    in_str = None
            elif c in "'\"":
                in_str = c
            elif c == '(':
                depth += 1
            elif c == ')':
                depth -= 1
            i += 1
        spans.append((m.start(), i))
    return spans


def wrap(src):
    spans = protected_spans(src)
    out, last, n = [], 0, 0
    for m in LIT.finditer(src):
        if any(a <= m.start() < b for a, b in spans):
            continue
        key = m.group(1)
        if key not in UI:
            continue
        line = src[src.rfind('\n', 0, m.start()) + 1:src.find('\n', m.start())].strip()
        if line.startswith(('import', 'export')):
            continue
        en = UI[key].replace('\\\\', '\x00').replace("\\'", "'").replace('\x00', '\\\\')
        out.append(src[last:m.start()])
        out.append(f"tr('{key}', {dart_q(en)})")
        last = m.end()
        n += 1
    out.append(src[last:])
    res = ''.join(out)
    # literales adyacentes: tr(..) tr(..) -> tr(..) + tr(..)
    res = re.sub(r"(tr\('(?:[^'\\]|\\.)*', '(?:[^'\\]|\\.)*'\))(\s*)(?=tr\()", r"\1 +\2", res)
    return res, n


def remove_const(src):
    """Quita `const` de cualquier expresión que contenga tr(."""
    stack = []  # (pos_open, const_start or None)
    removals = set()
    i, in_str, raw = 0, None, False
    n = len(src)
    while i < n:
        c = src[i]
        if in_str:
            if c == '\\' and not raw:
                i += 2
                continue
            if src.startswith(in_str, i):
                i += len(in_str)
                in_str = None
                continue
            i += 1
            continue
        if src.startswith('//', i):
            i = src.find('\n', i)
            if i < 0:
                break
            continue
        if c in "'\"":
            raw = i > 0 and src[i - 1] == 'r'
            in_str = c * 3 if src.startswith(c * 3, i) else c
            i += len(in_str)
            continue
        if src.startswith('tr(', i) and (i == 0 or not (src[i - 1].isalnum() or src[i - 1] == '_')):
            for (_, cs) in stack:
                if cs is not None:
                    removals.add(cs)
        if c in '([{':
            # ¿esta apertura pertenece a una expresión const?
            j = i - 1
            seg_end = i
            # retroceder sobre: identificadores, puntos, genéricos <...>, espacios
            k = j
            depth_angle = 0
            while k >= 0:
                ch = src[k]
                if ch == '>':
                    depth_angle += 1
                elif ch == '<':
                    depth_angle -= 1
                elif depth_angle == 0 and not (ch.isalnum() or ch in '_. \n\t'):
                    break
                k -= 1
            prefix = src[k + 1:seg_end]
            mm = re.search(r'\bconst\s+[\w.<>, ]*$', prefix)
            cs = (k + 1 + mm.start()) if mm else None
            stack.append((i, cs))
        elif c in ')]}':
            if stack:
                stack.pop()
        i += 1
    res = src
    for pos in sorted(removals, reverse=True):
        assert res.startswith('const', pos), res[pos:pos + 20]
        end = pos + 5
        while end < len(res) and res[end] in ' \t':
            end += 1
        res = res[:pos] + res[end:]
    return res, len(removals)


total = 0
for f in FILES:
    src = open(f, encoding='utf-8').read()
    src = src.replace('APOCA', 'AURORA')
    new, n = wrap(src)
    new, r = remove_const(new)
    if n or r or new != src:
        if "import '../core/i18n.dart';" not in new and "import 'core/i18n.dart';" not in new and 'tr(' in new:
            imp = "import 'core/i18n.dart';" if f == 'lib/main.dart' else "import '../core/i18n.dart';"
            # después del último import de package:
            idx = [m.end() for m in re.finditer(r"^import 'package:[^\n]*\n", new, re.M)]
            pos = idx[-1] if idx else 0
            new = new[:pos] + '\n' + imp + '\n' + new[pos:]
        open(f, 'w', encoding='utf-8').write(new)
    print(f'{f}: {n} textos, {r} const quitados')
    total += n
print('total', total)
