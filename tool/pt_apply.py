"""Genera lib/core/pt_ui.dart y agrega el portugués a los tr() con variables."""
import json, os, re, sys
sys.path.insert(0, 'tool')
from tr_extract import calls
S = sys.argv[1]
d = json.load(open(f'{S}/tr.json', encoding='utf-8'))
pt_lit = open(f'{S}/pt_lit.txt', encoding='utf-8').read().split('\n')
pt_int = [l for l in open(f'{S}/pt_interp.txt', encoding='utf-8').read().split('\n') if l]
keys, seen = [], set()
for o in d:
    if not o['interp'] and o['es'] not in seen:
        seen.add(o['es']); keys.append(o['es'])
assert len(keys) <= len(pt_lit)
def ev(src):  # valor aproximado para detectar claves repetidas
    return re.sub(r"""(^|\s)r?(['"])|(['"])(\s|$)""", ' ', src).strip()
out, vals = [], set()
for k, p in zip(keys, pt_lit):
    v = ev(k)
    if v in vals: continue
    vals.add(v)
    p = p.replace("'", "\\'").replace('$', '\\$')
    out.append(f"  {k}: '{p}',")
open('lib/core/pt_ui.dart', 'w', encoding='utf-8').write(
    "// Generado por tool/pt_apply.py: textos de la interfaz en portugués (clave = texto en español).\n"
    "const Map<String, String> ptUi = {\n" + '\n'.join(out) + '\n};\n')
interp_es = [o['es'] for o in d if o['interp']]
mapping = dict(zip(interp_es, pt_int))
n = 0
for root, _, files in os.walk('lib'):
    for f in files:
        p = os.path.join(root, f)
        s = open(p, encoding='utf-8').read()
        edits = [(close, mapping[es]) for st, close, es, en in calls(s) if es in mapping]
        for close, pt in sorted(edits, reverse=True):
            # quitar coma final si la hay
            j = close
            while s[j-1] in ' \n\t': j -= 1
            if s[j-1] == ',': j -= 1
            s = s[:j] + ', ' + pt + s[close:]
            n += 1
        open(p, 'w', encoding='utf-8').write(s)
print(len(out), 'pt keys;', n, 'interp edits')
