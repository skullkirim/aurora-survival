"""Extrae llamadas tr('es', 'en') de lib/ para traducir a portugués."""
import json, os, re, sys

def skip_ws(s, i):
    while i < len(s) and s[i] in ' \t\r\n': i += 1
    return i

def parse_lit(s, i):
    """Parse adjacent Dart string literals starting at i. Returns (end, srctext) or None."""
    start = i; parts = 0
    while True:
        i = skip_ws(s, i)
        raw = False
        if s.startswith("r'", i) or s.startswith('r"', i):
            raw = True; i += 1
        if i >= len(s) or s[i] not in "'\"": break
        q = s[i]
        triple = s.startswith(q*3, i)
        if triple:
            j = s.index(q*3, i+3) + 3
        else:
            j = i + 1
            while s[j] != q:
                if s[j] == '\\' and not raw: j += 2
                else: j += 1
            j += 1
        i = j; parts += 1
    if parts == 0: return None
    return i, s[start:i].strip()

def calls(s):
    for m in re.finditer(r'(?<![A-Za-z0-9_.])tr\(', s):
        i = m.end()
        a = parse_lit(s, i)
        if not a: continue
        i = skip_ws(s, a[0])
        if s[i] != ',': continue
        b = parse_lit(s, i+1)
        if not b: continue
        j = skip_ws(s, b[0])
        if s[j] == ',': j = skip_ws(s, j+1)
        if s[j] != ')': continue
        yield m.start(), j, a[1], b[1]

if __name__ == '__main__':
    out = []
    for root, _, files in os.walk('lib'):
        for f in files:
            if not f.endswith('.dart'): continue
            p = os.path.join(root, f)
            s = open(p, encoding='utf-8').read()
            for st, close, es, en in calls(s):
                interp = bool(re.search(r'(?<!\\)\$', es.replace("r'", "'")))
                out.append({'file': p, 'es': es, 'en': en, 'interp': interp})
    json.dump(out, open(sys.argv[1], 'w', encoding='utf-8'), ensure_ascii=False, indent=0)
    u = {o['es'] for o in out if not o['interp']}
    print(len(out), 'calls;', len(u), 'unique literal;', sum(o['interp'] for o in out), 'interpolated')
