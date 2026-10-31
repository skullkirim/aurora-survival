#!/usr/bin/env python3
"""Genera las ilustraciones SVG ligeras de APOCA en assets/ill/.

Estilo: pictogramas planos sobre fondo oscuro, sin texto (los textos van en la app).
Ejecutar:  python tool/gen_ill.py
"""
import math
import os

OUT = os.path.join(os.path.dirname(__file__), '..', 'assets', 'ill')
W, H = 320, 200

# Paleta
BG = '#141414'
GROUND = '#2A2A2A'
SKIN = '#E0A877'
SHIRT = '#42A5F5'
PANTS = '#37474F'
RED = '#E53935'
AMBER = '#FFB300'
ORANGE = '#FF7043'
BLUE = '#42A5F5'
LBLUE = '#90CAF9'
GREEN = '#66BB6A'
DGREEN = '#2E7D32'
BROWN = '#8D6E63'
DBROWN = '#5D4037'
GRAY = '#9E9E9E'
DGRAY = '#616161'
WHITE = '#EEEEEE'
YELLOW = '#FDD835'
PURPLE = '#AB47BC'


DEFS = (
    '<defs>'
    '<linearGradient id="bgG" x1="0" y1="0" x2="0" y2="1"><stop offset="0" stop-color="#1E2A3A"/><stop offset="1" stop-color="#0D1117"/></linearGradient>'
    '<linearGradient id="groundG" x1="0" y1="0" x2="0" y2="1"><stop offset="0" stop-color="#4E6B3A"/><stop offset="0.25" stop-color="#34482A"/><stop offset="1" stop-color="#1E2A18"/></linearGradient>'
    '<radialGradient id="glowG"><stop offset="0" stop-color="#FFB300" stop-opacity="0.55"/><stop offset="1" stop-color="#FFB300" stop-opacity="0"/></radialGradient>'
    '<radialGradient id="fireGlow"><stop offset="0" stop-color="#FF7043" stop-opacity="0.6"/><stop offset="1" stop-color="#FF7043" stop-opacity="0"/></radialGradient>'
    '<radialGradient id="sunG" cx="40%" cy="35%"><stop offset="0" stop-color="#FFF59D"/><stop offset="1" stop-color="#FFA000"/></radialGradient>'
    '<linearGradient id="flameG" x1="0" y1="1" x2="0" y2="0"><stop offset="0" stop-color="#E64A19"/><stop offset="0.6" stop-color="#FF7043"/><stop offset="1" stop-color="#FFCA28"/></linearGradient>'
    '<linearGradient id="flameIn" x1="0" y1="1" x2="0" y2="0"><stop offset="0" stop-color="#FFA000"/><stop offset="1" stop-color="#FFF59D"/></linearGradient>'
    '<radialGradient id="skinG" cx="40%" cy="35%"><stop offset="0" stop-color="#F3C49A"/><stop offset="1" stop-color="#C98B5B"/></radialGradient>'
    '<linearGradient id="waterG" x1="0" y1="0" x2="0" y2="1"><stop offset="0" stop-color="#81D4FA"/><stop offset="1" stop-color="#1976D2"/></linearGradient>'
    '<linearGradient id="leafG" x1="0" y1="0" x2="1" y2="1"><stop offset="0" stop-color="#9CCC65"/><stop offset="1" stop-color="#2E7D32"/></linearGradient>'
    '<linearGradient id="trunkG" x1="0" y1="0" x2="1" y2="0"><stop offset="0" stop-color="#6D4C41"/><stop offset="1" stop-color="#3E2723"/></linearGradient>'
    '<radialGradient id="crownG" cx="35%" cy="30%"><stop offset="0" stop-color="#66BB6A"/><stop offset="1" stop-color="#1B5E20"/></radialGradient>'
    '<linearGradient id="metalG" x1="0" y1="0" x2="0" y2="1"><stop offset="0" stop-color="#90A4AE"/><stop offset="0.5" stop-color="#607D8B"/><stop offset="1" stop-color="#37474F"/></linearGradient>'
    '<linearGradient id="darkMetalG" x1="0" y1="0" x2="0" y2="1"><stop offset="0" stop-color="#757575"/><stop offset="1" stop-color="#303030"/></linearGradient>'
    '<linearGradient id="woodG" x1="0" y1="0" x2="0" y2="1"><stop offset="0" stop-color="#A1887F"/><stop offset="1" stop-color="#5D4037"/></linearGradient>'
    '<linearGradient id="dwoodG" x1="0" y1="0" x2="0" y2="1"><stop offset="0" stop-color="#795548"/><stop offset="1" stop-color="#3E2723"/></linearGradient>'
    '<linearGradient id="blueG" x1="0" y1="0" x2="0" y2="1"><stop offset="0" stop-color="#64B5F6"/><stop offset="1" stop-color="#1565C0"/></linearGradient>'
    '<linearGradient id="redG" x1="0" y1="0" x2="0" y2="1"><stop offset="0" stop-color="#EF5350"/><stop offset="1" stop-color="#B71C1C"/></linearGradient>'
    '<radialGradient id="vign" cx="50%" cy="45%" r="75%"><stop offset="0.6" stop-color="#000" stop-opacity="0"/><stop offset="1" stop-color="#000" stop-opacity="0.45"/></radialGradient>'
    '</defs>'
)


_FILL_MAP = {
    f'fill="{GRAY}"': 'fill="url(#metalG)"',
    f'fill="{DGRAY}"': 'fill="url(#darkMetalG)"',
    f'fill="{BROWN}"': 'fill="url(#woodG)"',
    f'fill="{DBROWN}"': 'fill="url(#dwoodG)"',
    f'fill="{BLUE}"': 'fill="url(#blueG)"',
    f'fill="{RED}"': 'fill="url(#redG)"',
}
_NO_OUTLINE = ('url(#glowG)', 'url(#fireGlow)', 'fill="none"', 'fill-opacity', 'url(#groundG)')


def _style(body):
    import re as _re
    for a, b in _FILL_MAP.items():
        body = body.replace(a, b)

    def outline(m):
        tag = m.group(0)
        if 'stroke=' in tag or any(k in tag for k in _NO_OUTLINE):
            return tag
        return tag[:-2] + ' stroke="#000000" stroke-opacity="0.45" stroke-width="1.4"/>'
    return _re.sub(r'<(?:path|rect|circle|polygon|ellipse)\b[^>]*/>', outline, body)


def svg(body, bg=True):
    body = _style(body)
    back = f'<rect width="{W}" height="{H}" rx="14" fill="url(#bgG)"/>' if bg else ''
    vign = f'<rect width="{W}" height="{H}" rx="14" fill="url(#vign)"/>' if bg else ''
    return (f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {W} {H}" '
            f'width="{W}" height="{H}">{DEFS}{back}{body}{vign}</svg>')


def shadow(x, y, rx, ry=6):
    return f'<ellipse cx="{x}" cy="{y}" rx="{rx}" ry="{ry}" fill="#000" fill-opacity="0.35"/>'


def line(x1, y1, x2, y2, c=WHITE, w=4, dash=None):
    d = f' stroke-dasharray="{dash}"' if dash else ''
    return (f'<line x1="{x1}" y1="{y1}" x2="{x2}" y2="{y2}" stroke="{c}" '
            f'stroke-width="{w}" stroke-linecap="round"{d}/>')


def poly(points, c, stroke=None, w=0, close=True):
    pts = ' '.join(f'{x},{y}' for x, y in points)
    tag = 'polygon' if close else 'polyline'
    fill = c if close else 'none'
    s = f' stroke="{stroke}" stroke-width="{w}" stroke-linejoin="round" stroke-linecap="round"' if stroke else ''
    return f'<{tag} points="{pts}" fill="{fill}"{s}/>'


def circle(x, y, r, c, stroke=None, w=0):
    s = f' stroke="{stroke}" stroke-width="{w}"' if stroke else ''
    return f'<circle cx="{x}" cy="{y}" r="{r}" fill="{c}"{s}/>'


def ring(x, y, r, c, w=4, dash=None):
    d = f' stroke-dasharray="{dash}"' if dash else ''
    return f'<circle cx="{x}" cy="{y}" r="{r}" fill="none" stroke="{c}" stroke-width="{w}"{d}/>'


def rect(x, y, w, h, c, r=0, stroke=None, sw=0):
    s = f' stroke="{stroke}" stroke-width="{sw}"' if stroke else ''
    return f'<rect x="{x}" y="{y}" width="{w}" height="{h}" rx="{r}" fill="{c}"{s}/>'


def path(d, c='none', stroke=None, w=0):
    s = f' stroke="{stroke}" stroke-width="{w}" stroke-linecap="round" stroke-linejoin="round"' if stroke else ''
    return f'<path d="{d}" fill="{c}"{s}/>'


def arrow(x1, y1, x2, y2, c=AMBER, w=5):
    a = math.atan2(y2 - y1, x2 - x1)
    l = 12
    p1 = (x2 - l * math.cos(a - 0.5), y2 - l * math.sin(a - 0.5))
    p2 = (x2 - l * math.cos(a + 0.5), y2 - l * math.sin(a + 0.5))
    return line(x1, y1, x2, y2, c, w) + poly([(x2, y2), p1, p2], c)


def g(body, tx=0, ty=0, s=1, rot=0):
    return f'<g transform="translate({tx},{ty}) rotate({rot}) scale({s})">{body}</g>'


def ground(y=170):
    tufts = ''.join(
        path(f'M{x} {y + 6} l3 -9 l2 9 l3 -7 l2 7', 'none', '#6B8E4E', 2) for x in range(18, W - 20, 47))
    return (f'<path d="M0 {y} Q{W * 0.25} {y - 6} {W / 2} {y} T{W} {y} V{H - 14} Q{W} {H} {W - 14} {H} H14 Q0 {H} 0 {H - 14} Z" '
            f'fill="url(#groundG)"/>' + tufts)


def sun(x, y, r=16):
    rays = ''.join(line(x + math.cos(a) * (r + 6), y + math.sin(a) * (r + 6),
                        x + math.cos(a) * (r + 13), y + math.sin(a) * (r + 13), AMBER, 3)
                   for a in [i * math.pi / 4 for i in range(8)])
    return circle(x, y, r * 2.6, 'url(#glowG)') + rays + circle(x, y, r, 'url(#sunG)')


def _head(cx, cy, r=13, hair='#3E2723'):
    return (circle(cx, cy, r, 'url(#skinG)') +
            path(f'M{cx - r} {cy - 1} A{r} {r} 0 0 1 {cx + r} {cy - 1} Q{cx + r * 0.4} {cy - r * 0.55} {cx - r} {cy - 1} Z', hair) +
            circle(cx + r * 0.38, cy + 1, 1.6, '#3E2723'))


def person(x, y, s=1, shirt=SHIRT, pose='stand'):
    """Figura con sombra, ropa y cabello. (x,y)=pies centro."""
    b = shadow(0, 2, 26, 6)
    b += line(-8, -2, -6, -38, PANTS, 10) + line(8, -2, 6, -38, PANTS, 10)
    b += rect(-15, -4, 13, 6, '#212121', 3) + rect(3, -4, 13, 6, '#212121', 3)
    b += path('M-14 -76 Q0 -82 14 -76 L13 -36 Q0 -32 -13 -36 Z', shirt)
    b += path('M-14 -76 Q0 -82 14 -76 L13 -66 Q0 -70 -14 -66 Z', '#FFFFFF', None) .replace('fill="#FFFFFF"', 'fill="#FFFFFF" fill-opacity="0.12"')
    b += line(-13, -70, -21, -42, shirt, 8) + line(13, -70, 21, -42, shirt, 8)
    b += circle(-21, -39, 4.5, 'url(#skinG)') + circle(21, -39, 4.5, 'url(#skinG)')
    b += rect(-4, -84, 8, 8, 'url(#skinG)', 2)
    b += _head(0, -94, 13)
    return g(b, x, y, s)


def lying(x, y, s=1, shirt=SHIRT):
    """Persona acostada boca arriba, cabeza a la izquierda. (x,y)=centro del cuerpo en el suelo."""
    b = shadow(-4, 2, 64, 5)
    b += g(_head(0, 0, 12), -58, -12, 1, -90)
    b += path('M-46 -24 Q-20 -28 2 -22 L2 0 Q-20 4 -46 0 Z', shirt)
    b += line(2, -14, 50, -10, PANTS, 10) + line(2, -6, 50, -2, PANTS, 10)
    b += rect(48, -16, 7, 10, '#212121', 3) + rect(48, -8, 7, 10, '#212121', 3)
    return g(b, x, y, s)


def flame(x, y, s=1):
    b = f'<ellipse cx="0" cy="-22" rx="46" ry="40" fill="url(#fireGlow)"/>'
    b += path('M0 0 C-24 -10 -16 -36 0 -56 C3 -38 20 -34 15 -14 C13 -5 8 0 0 0 Z', 'url(#flameG)')
    b += path('M0 0 C-11 -6 -9 -22 0 -32 C2 -21 11 -17 7 -6 C5 -2 3 0 0 0 Z', 'url(#flameIn)')
    return g(b, x, y, s)


def leaf(x, y, s=1, rot=0, c=GREEN):
    fill = 'url(#leafG)' if c == GREEN else c
    b = path('M0 0 C10 -20 30 -22 40 -20 C36 -6 22 8 0 0 Z', fill) + line(0, 0, 32, -16, '#1B5E20', 2)
    b += line(12, -6, 14, -13, '#1B5E20', 1) + line(22, -11, 25, -17, '#1B5E20', 1)
    return g(b, x, y, s, rot)


def drop(x, y, s=1, c=BLUE):
    fill = 'url(#waterG)' if c == BLUE else c
    b = path('M0 -20 C8 -8 12 -2 12 5 C12 12 6 16 0 16 C-6 16 -12 12 -12 5 C-12 -2 -8 -8 0 -20 Z', fill)
    b += f'<ellipse cx="-4" cy="4" rx="3" ry="5" fill="#FFFFFF" fill-opacity="0.5"/>'
    return g(b, x, y, s)


def tree(x, y, s=1):
    b = shadow(0, 2, 30, 5)
    b += path('M-6 0 L-4 -34 L4 -34 L6 0 Z', 'url(#trunkG)')
    b += circle(-17, -38, 17, 'url(#crownG)') + circle(17, -38, 17, 'url(#crownG)') + circle(0, -52, 25, 'url(#crownG)')
    b += circle(-6, -60, 7, '#81C784', None).replace('fill="#81C784"', 'fill="#81C784" fill-opacity="0.35"')
    return g(b, x, y, s)


def check(x, y, c=GREEN):
    return path(f'M{x - 12} {y} L{x - 3} {y + 10} L{x + 14} {y - 10}', 'none', c, 6)


def cross(x, y, c=RED, r=11):
    return line(x - r, y - r, x + r, y + r, c, 6) + line(x + r, y - r, x - r, y + r, c, 6)


ILL = {}
# (las ilustraciones usan los ayudantes de arriba: gradientes, sombras y figuras detalladas)

# =====================================================================
# PORTADAS DE CATEGORÍA
# =====================================================================
ILL['cat_auxilios'] = svg(
    rect(110, 40, 100, 120, WHITE, 16) + rect(145, 60, 30, 80, RED, 4) + rect(120, 85, 80, 30, RED, 4) +
    g(rect(-40, -10, 80, 20, '#F5DEB3', 8) + circle(-14, 0, 2, BROWN) + circle(0, 0, 2, BROWN) + circle(14, 0, 2, BROWN),
      250, 150, 1, -30) + circle(70, 60, 18, RED, None) + path('M58 60 h24 M70 48 v24', 'none', WHITE, 5))
ILL['cat_agua'] = svg(
    ground() + rect(100, 120, 120, 50, DGRAY, 10) + rect(92, 112, 136, 14, GRAY, 6) +
    flame(160, 190, 0.9) + drop(160, 70, 2.2) + path('M120 112 q5 -14 0 -26 M150 112 q5 -14 0 -26 M180 112 q5 -14 0 -26', 'none', LBLUE, 3) +
    drop(60, 60, 0.8, LBLUE) + drop(260, 80, 0.8, LBLUE))
ILL['cat_fuego'] = svg(
    ground() + line(110, 168, 210, 150, BROWN, 12) + line(110, 150, 210, 168, BROWN, 12) + flame(160, 160, 2.2) +
    circle(90, 40, 3, AMBER) + circle(230, 55, 3, AMBER) + circle(200, 30, 2, AMBER))
ILL['cat_refugio'] = svg(
    ground() + tree(50, 170, 1.1) + tree(270, 170, 1.1) + line(50, 95, 270, 95, BROWN, 6) +
    poly([(60, 95), (260, 95), (285, 170), (35, 170)], DGREEN) +
    ''.join(line(70 + i * 22, 97, 55 + i * 25, 168, '#1B5E20', 4) for i in range(9)) + flame(160, 196, 0.5))
ILL['cat_comida'] = svg(
    ground() + rect(70, 110, 110, 55, DGRAY, 12) + rect(62, 104, 126, 12, GRAY, 6) +
    path('M90 104 q4 -12 0 -22 M125 104 q4 -12 0 -22 M160 104 q4 -12 0 -22', 'none', GRAY, 3) +
    g(path('M0 0 C20 -18 50 -18 66 0 C50 18 20 18 0 0 Z', LBLUE) + poly([(62, 0), (84, -14), (84, 14)], LBLUE) + circle(14, -3, 3, BG),
      205, 90) + circle(240, 150, 14, RED) + leaf(240, 136, 0.5, -80))
ILL['cat_plantas'] = svg(
    ground() + line(160, 170, 160, 80, DGREEN, 6) + leaf(160, 140, 1.4, -20) + leaf(160, 120, 1.4, 200) +
    leaf(160, 100, 1.2, -40) + circle(90, 80, 22, ORANGE) + leaf(90, 58, 0.6, -70) +
    circle(240, 90, 14, PURPLE) + circle(258, 100, 14, PURPLE) + circle(246, 110, 14, PURPLE))
ILL['cat_medicina_natural'] = svg(
    ground() + path('M110 120 h100 l-14 48 h-72 z', DBROWN) + rect(104, 112, 112, 12, BROWN, 6) +
    line(200, 70, 160, 130, GRAY, 10) + circle(200, 70, 9, GRAY) + leaf(60, 160, 1.2, -60) + leaf(250, 160, 1.1, -120) +
    leaf(230, 70, 0.9, -20) + circle(80, 70, 10, YELLOW) + circle(80, 70, 4, ORANGE))
ILL['cat_orientacion'] = svg(
    ring(160, 100, 62, WHITE, 6) + poly([(160, 46), (150, 100), (170, 100)], RED) + poly([(160, 154), (150, 100), (170, 100)], GRAY) +
    circle(160, 100, 6, WHITE) + sun(265, 45, 16) + ''.join(circle(40 + x, 40 + y, 2.5, WHITE) for x, y in [(0, 0), (10, 30), (-6, 50), (24, 22)]))
ILL['cat_nudos'] = svg(
    path('M40 140 C90 140 100 60 150 60 C200 60 210 130 170 130 C130 130 140 80 180 80 C230 80 240 140 290 140',
         'none', AMBER, 12) + path('M40 140 C90 140 100 60 150 60', 'none', '#FFCA28', 4))
ILL['cat_desastres'] = svg(
    ground() + poly([(90, 170), (90, 100), (160, 50), (230, 100), (230, 170)], DGRAY) +
    path('M150 70 l10 25 l-14 15 l12 25 l-8 35', 'none', BG, 6) + rect(110, 120, 30, 30, LBLUE, 2) + rect(185, 120, 30, 50, BROWN, 2) +
    path('M20 120 q10 -10 20 0 t20 0 M260 120 q10 -10 20 0 t20 0', 'none', AMBER, 4))
_trefoil = ''.join(
    path(f'M0 0 L{math.cos(a - 0.52) * 60:.1f} {math.sin(a - 0.52) * 60:.1f} '
         f'A60 60 0 0 1 {math.cos(a + 0.52) * 60:.1f} {math.sin(a + 0.52) * 60:.1f} Z', BG)
    for a in [-math.pi / 2, math.pi / 6, 5 * math.pi / 6])
ILL['cat_radiacion'] = svg(circle(160, 100, 72, YELLOW) + g(_trefoil, 160, 100) + circle(160, 100, 14, YELLOW) + circle(160, 100, 9, BG))
ILL['cat_animales'] = svg(
    ground() + path('M40 160 C70 120 110 170 140 130 C170 90 210 150 240 110 C255 90 270 90 280 100', 'none', '#8D6E63', 16) +
    path('M40 160 C70 120 110 170 140 130 C170 90 210 150 240 110', 'none', '#6D4C41', 4, ) +
    circle(284, 104, 14, '#8D6E63') + circle(289, 99, 3, YELLOW) + line(296, 108, 308, 112, RED, 2) +
    g(circle(0, 0, 9, GREEN) + circle(-4, -4, 2, BG), 70, 60) + g(circle(0, 0, 9, YELLOW) + circle(-4, -4, 2, BG), 95, 70))
ILL['cat_comunicacion'] = svg(
    rect(130, 70, 60, 100, DGRAY, 10) + line(150, 70, 140, 25, GRAY, 5) + rect(140, 85, 40, 25, LBLUE, 4) +
    circle(160, 140, 12, GRAY) + ''.join(path(f'M{190 + i * 18} {60 - i * 4} q{14} 30 0 {60 + i * 8}', 'none', AMBER, 4) for i in range(3)) +
    ''.join(path(f'M{130 - i * 18} {60 - i * 4} q-14 30 0 {60 + i * 8}', 'none', AMBER, 4) for i in range(3)))
ILL['cat_reconstruir'] = svg(
    ground() + poly([(40, 170), (40, 110), (95, 70), (150, 110), (150, 170)], BROWN) + poly([(30, 112), (95, 62), (160, 112)], DBROWN) +
    rect(80, 130, 26, 40, DBROWN) + ''.join(line(190 + i * 22, 170, 190 + i * 22, 120, GREEN, 4) + leaf(190 + i * 22, 140, 0.5, -60) +
                                              leaf(190 + i * 22, 130, 0.5, 240) + circle(190 + i * 22, 118, 5, YELLOW) for i in range(5)) + sun(270, 40, 14))
ILL['cat_mente'] = svg(
    circle(160, 90, 50, SKIN) + rect(135, 130, 50, 40, SHIRT, 12) +
    path('M160 80 C150 64 128 72 136 90 C142 102 160 112 160 112 C160 112 178 102 184 90 C192 72 170 64 160 80 Z', RED) +
    ''.join(ring(160, 90, r, AMBER, 2, '4 6') for r in [64, 80]))

# =====================================================================
# PRIMEROS AUXILIOS
# =====================================================================
ILL['rcp_manos'] = svg(
    ground(150) + lying(150, 150, 1.4) +
    rect(118, 94, 34, 14, SKIN, 6) + rect(122, 82, 26, 14, SKIN, 6) +
    line(128, 82, 115, 30, SHIRT, 10) + line(142, 82, 150, 30, SHIRT, 10) +
    arrow(190, 40, 190, 92, RED) + arrow(210, 92, 210, 50, GRAY, 3) +
    circle(270, 50, 20, 'none', RED, 4) + path('M262 50 l6 6 l12 -12', 'none', RED, 4))
ILL['torniquete'] = svg(
    path('M20 90 C80 80 200 80 300 95 L300 135 C200 120 80 120 20 130 Z', SKIN) +
    circle(230, 112, 9, RED) + path('M230 121 q4 14 0 26', 'none', RED, 4) +
    rect(150, 80, 26, 56, '#455A64', 4) + line(140, 72, 186, 144, BROWN, 8) +
    arrow(200, 60, 178, 78, AMBER) + path('M120 50 a20 20 0 1 1 0.1 0', 'none', AMBER, 3) +
    line(120, 50, 120, 38, AMBER, 3) + line(120, 50, 130, 50, AMBER, 3))
ILL['presion_herida'] = svg(
    ground(160) + path('M20 120 C100 110 220 110 300 120 L300 158 C220 150 100 150 20 158 Z', PANTS) +
    rect(130, 104, 70, 22, WHITE, 6) + circle(165, 122, 6, RED) +
    rect(132, 78, 30, 30, SKIN, 10) + rect(166, 78, 30, 30, SKIN, 10) +
    line(146, 78, 130, 20, SHIRT, 12) + line(180, 78, 196, 20, SHIRT, 12) + arrow(240, 40, 240, 100, AMBER))
ILL['heimlich'] = svg(
    ground() + person(150, 170, 1.1, ORANGE) + g(line(-8, 0, -5, -38, PANTS, 9) + line(8, 0, 5, -38, PANTS, 9) +
                                                  rect(-13, -78, 26, 44, SHIRT, 9) + circle(0, -92, 13, SKIN), 185, 170, 1.15) +
    line(176, 92, 152, 105, SHIRT, 8) + circle(150, 106, 7, SKIN) + arrow(120, 130, 140, 100, AMBER) +
    arrow(250, 70, 230, 60, RED, 4))
ILL['suero_oral'] = svg(
    ground() + rect(60, 70, 80, 100, LBLUE, 12) + rect(60, 70, 80, 30, BG, 0) + rect(56, 66, 88, 10, GRAY, 4) +
    rect(64, 100, 72, 66, BLUE, 8) +
    ''.join(g(rect(-22, -4, 30, 8, GRAY, 4) + circle(14, 0, 9, WHITE), 200 + (i % 3) * 32, 70 + (i // 3) * 26) for i in range(6)) +
    g(rect(-22, -4, 30, 8, GRAY, 4) + circle(14, 0, 9, '#B0BEC5'), 216, 140) + arrow(160, 110, 145, 110, AMBER, 4))
ILL['serpiente_inmovilizar'] = svg(
    path('M20 90 C80 80 200 80 300 95 L300 135 C200 120 80 120 20 130 Z', SKIN) +
    rect(40, 76, 230, 12, BROWN, 4) + rect(40, 128, 230, 12, BROWN, 4) +
    ''.join(rect(70 + i * 60, 70, 14, 76, WHITE, 3) for i in range(4)) +
    circle(250, 108, 4, RED) + circle(260, 110, 4, RED) + cross(60, 40, RED, 10) + path('M90 40 q10 -10 20 0 t20 0', 'none', '#8D6E63', 6))
ILL['quemadura'] = svg(
    rect(150, 20, 30, 30, GRAY, 4) + ''.join(line(158 + i * 7, 52, 158 + i * 7, 110, LBLUE, 3, '6 6') for i in range(3)) +
    path('M40 130 C100 118 220 118 290 132 L290 170 C220 160 100 160 40 170 Z', SKIN) + circle(170, 140, 14, '#EF9A9A') +
    cross(70, 60, RED, 10) + g(rect(-12, -14, 24, 28, WHITE, 4), 260, 60))

# =====================================================================
# AGUA
# =====================================================================
ILL['hervir_agua'] = svg(
    ground() + flame(160, 190, 1.0) + rect(100, 100, 120, 60, DGRAY, 10) + rect(94, 94, 132, 10, GRAY, 5) +
    ''.join(circle(120 + i * 20, 90 - (i % 2) * 10, 6, LBLUE) for i in range(5)) +
    ring(270, 60, 26, WHITE, 4) + line(270, 60, 270, 42, WHITE, 4) + line(270, 60, 284, 60, AMBER, 4))
ILL['cloro_gotas'] = svg(
    ground() + rect(60, 60, 50, 90, WHITE, 10) + rect(72, 40, 26, 24, RED, 4) + drop(130, 80, 0.5, '#FFF59D') +
    drop(130, 105, 0.5, '#FFF59D') + rect(160, 90, 100, 80, LBLUE, 8) + rect(160, 90, 100, 18, BG) + rect(165, 108, 90, 58, BLUE, 6) +
    ring(285, 50, 20, WHITE, 3) + line(285, 50, 285, 38, WHITE, 3) + line(285, 50, 295, 56, WHITE, 3))
ILL['sodis'] = svg(
    sun(60, 45, 20) + ''.join(line(80 + i * 8, 70 + i * 6, 120 + i * 10, 120, AMBER, 2, '4 6') for i in range(4)) +
    poly([(100, 160), (300, 120), (300, 135), (100, 175)], DBROWN) +
    ''.join(g(rect(-12, -40, 24, 44, LBLUE, 8) + rect(-6, -48, 12, 8, BLUE, 2), 0, 0, 1, 80) for _ in []) +
    ''.join(g(rect(-34, -10, 60, 22, LBLUE, 9) + rect(26, -5, 10, 12, BLUE, 2), 150 + i * 50, 152 - i * 10, 1, -11) for i in range(3)))
ILL['filtro_capas'] = svg(
    path('M120 20 h80 l-6 150 h-68 z', 'none', WHITE, 4) +
    path('M123 40 h74 l-1 25 h-72 z', '#9E9E9E') + path('M124 65 h72 l-1 25 h-70 z', '#BCAAA4') +
    path('M125 90 h70 l-1 25 h-68 z', '#FFE0B2') + path('M126 115 h68 l-1 25 h-66 z', '#212121') +
    path('M127 140 h66 l-1 18 h-64 z', WHITE) + drop(160, 186, 0.45) + drop(70, 30, 0.8, '#A1887F') +
    arrow(70, 50, 110, 60, AMBER, 4) + rect(230, 140, 60, 40, LBLUE, 6))
ILL['destilador_solar'] = svg(
    sun(270, 40, 16) + path('M20 110 H300 V186 Q300 190 290 190 H30 Q20 190 20 180 Z', GROUND) +
    path('M70 110 Q160 190 250 110 Z', '#3E2723') + path('M60 110 Q160 150 260 110', 'none', LBLUE, 3) +
    circle(160, 128, 7, GRAY) + rect(145, 150, 30, 24, WHITE, 3) + rect(148, 160, 24, 12, BLUE, 2) +
    leaf(95, 135, 0.6, -30) + leaf(215, 135, 0.6, 210) + drop(160, 145, 0.25))
ILL['agua_lluvia'] = svg(
    ''.join(line(30 + i * 30, 10 + (i % 3) * 8, 22 + i * 30, 34 + (i % 3) * 8, LBLUE, 2) for i in range(10)) +
    ground() + line(70, 170, 80, 80, BROWN, 6) + line(250, 170, 240, 80, BROWN, 6) +
    path('M80 80 Q160 140 240 80', 'none', BLUE, 6) + path('M80 80 Q160 140 240 80 L160 120 Z', BLUE) +
    rect(140, 130, 40, 40, GRAY, 6) + drop(160, 125, 0.3))

# =====================================================================
# FUEGO
# =====================================================================
ILL['fuego_tipi'] = svg(
    ground() + ''.join(line(160, 60, 110 + i * 25, 170, BROWN, 6) for i in range(5)) +
    flame(160, 170, 1.0) + g(path('M0 0 q10 -10 22 -4 q8 -8 18 0 q-10 14 -40 4 z', '#D7CCC8'), 145, 172))
ILL['fuego_estructuras'] = svg(
    ground() +
    g(''.join(line(0, -60, -30 + i * 15, 0, BROWN, 5) for i in range(5)) + flame(0, 0, 0.6), 60, 168) +
    g(''.join(line(-30, -i * 12, 30, -i * 12, BROWN if i % 2 == 0 else DBROWN, 7) for i in range(5)) +
      ''.join(line(-24 + (i % 2) * 48, -i * 12, -24 + (i % 2) * 48, -i * 12 - 10, BROWN, 6) for i in range(5)) + flame(0, -4, 0.5), 160, 165) +
    g(''.join(line(0, 0, math.cos(a) * 45, math.sin(a) * 18, BROWN, 7) for a in [0, 1.25, 2.5, 3.75, 5.0]) + flame(0, 2, 0.6), 260, 160))
ILL['yesca'] = svg(
    ground() + g(path('M0 0 q20 -30 50 -6 q20 -20 40 6 q-40 20 -90 0 z', '#D7CCC8'), 40, 150) +
    ''.join(line(160, 160 - i * 6, 210, 150 - i * 6, BROWN, 2) for i in range(5)) +
    ''.join(line(230, 165 - i * 10, 300, 155 - i * 10, BROWN, 7) for i in range(3)) + arrow(100, 120, 150, 120, AMBER, 3) +
    arrow(215, 120, 235, 120, AMBER, 3) + rect(40, 40, 60, 14, GRAY, 6) + line(100, 47, 130, 30, WHITE, 3))

# =====================================================================
# REFUGIO
# =====================================================================
ILL['refugio_leanto'] = svg(
    ground() + tree(60, 170, 1.0) + tree(260, 170, 1.0) + line(60, 100, 260, 100, BROWN, 6) +
    poly([(65, 100), (255, 100), (230, 170), (90, 170)], DGREEN) + flame(160, 196, 0.45) +
    ''.join(line(110 + i * 12, 180, 110 + i * 12, 150, DBROWN, 6) for i in range(9)) +
    arrow(150, 150, 150, 125, AMBER, 3))
ILL['refugio_aframe'] = svg(
    ground() + rect(250, 140, 20, 30, BROWN) + poly([(40, 170), (260, 130), (260, 170)], '#6D4C41') +
    ''.join(line(60 + i * 20, 168, 70 + i * 18, 140 - i * 1, BROWN, 4) for i in range(10)) +
    ''.join(leaf(50 + i * 22, 168 - i * 3, 0.5, -30 - i * 5, '#A1887F') for i in range(10)))
ILL['aislar_suelo'] = svg(
    path('M10 100 H155 V186 Q155 190 145 190 H20 Q10 190 10 180 Z', GROUND) + lying(80, 100, 0.9) +
    ''.join(arrow(40 + i * 25, 115, 40 + i * 25, 150, LBLUE, 3) for i in range(4)) + cross(130, 40, RED, 10) +
    path('M165 100 H310 V180 Q310 190 300 190 H175 Q165 190 165 180 Z', GROUND) +
    ''.join(line(175, 92 + i * 4, 300, 92 + i * 4, BROWN, 3) for i in range(3)) + lying(240, 90, 0.9) + check(290, 40))
ILL['capas_ropa'] = svg(
    ''.join(g(rect(-28, -50, 56, 90, c, 14) + line(-26, -40, -40, 20, c, 12) + line(26, -40, 40, 20, c, 12), 70 + i * 90, 100)
            for i, c in enumerate(['#BDBDBD', '#FF8A65', '#1E88E5'])) +
    arrow(110, 40, 140, 40, AMBER, 3) + arrow(200, 40, 230, 40, AMBER, 3))

# =====================================================================
# COMIDA
# =====================================================================
ILL['pesca_nasa'] = svg(
    rect(0, 70, W, 130, '#0D47A1', 14) + path('M60 120 L230 100 L230 160 L60 140 Z', '#B3E5FC') +
    path('M230 100 L200 125 L200 135 L230 160', 'none', WHITE, 3) + path('M60 120 L60 140', 'none', WHITE, 3) +
    g(path('M0 0 C10 -9 26 -9 34 0 C26 9 10 9 0 0 Z', ORANGE) + poly([(32, 0), (44, -8), (44, 8)], ORANGE), 120, 128) +
    g(path('M0 0 C10 -9 26 -9 34 0 C26 9 10 9 0 0 Z', ORANGE) + poly([(32, 0), (44, -8), (44, 8)], ORANGE), 270, 115, 1, 180) +
    arrow(300, 130, 250, 130, AMBER, 3))
ILL['caja_calor'] = svg(
    ground() + rect(70, 60, 180, 110, BROWN, 6) + rect(85, 75, 150, 95, '#FFE0B2', 4) +
    rect(120, 100, 80, 60, DGRAY, 10) + rect(114, 94, 92, 10, GRAY, 5) + path('M140 92 q4 -12 0 -22', 'none', GRAY, 3) +
    rect(60, 40, 200, 22, DBROWN, 4))
ILL['secado'] = svg(
    sun(270, 40, 16) + line(30, 60, 230, 60, GRAY, 3) +
    ''.join(rect(40 + i * 38, 64, 22, 60, '#A1887F' if i % 2 else '#D84315', 6) for i in range(5)) +
    ground() + line(30, 60, 30, 170, BROWN, 6) + line(230, 60, 230, 170, BROWN, 6))
ILL['insectos'] = svg(
    g(rect(-30, -10, 60, 20, '#5D4037', 10) + circle(-34, 0, 10, '#4E342E') + ''.join(line(-15 + i * 15, 8, -20 + i * 15, 22, '#4E342E', 3) for i in range(3)), 90, 80) +
    g(path('M0 0 C20 -10 60 -10 80 0 C60 12 20 12 0 0 Z', GREEN) + line(70, -4, 100, -30, GREEN, 3) + line(40, 6, 60, 30, GREEN, 3), 160, 90) +
    flame(160, 190, 0.6) + rect(110, 130, 100, 14, GRAY, 6))

# =====================================================================
# PLANTAS / MEDICINA
# =====================================================================
ILL['planta_peligro'] = svg(
    leaf(80, 120, 1.6, -60) + path('M88 112 q8 10 4 24', 'none', WHITE, 4) + drop(96, 150, 0.4, WHITE) + cross(80, 40) +
    g(path('M0 0 L-14 50 L14 50 Z', WHITE) + path('M0 0 L-6 50 L6 50 Z', YELLOW), 170, 40) + cross(170, 30) +
    g(circle(0, 0, 16, RED) + circle(-6, -5, 3, WHITE) + line(0, -16, 0, -36, DGREEN, 3), 260, 120) + cross(260, 70))
ILL['infusion'] = svg(
    ground() + path('M110 100 h100 l-10 66 h-80 z', WHITE) + path('M210 115 q30 0 20 25 q-6 12 -24 10', 'none', WHITE, 6) +
    rect(116, 104, 88, 14, '#A5D6A7', 4) + leaf(130, 110, 0.5, -20) + leaf(170, 112, 0.5, -10) +
    path('M135 92 q8 -14 0 -28 M160 92 q8 -14 0 -28 M185 92 q8 -14 0 -28', 'none', GRAY, 3) + leaf(40, 80, 0.9, -40) + leaf(260, 60, 0.8, -140))
ILL['cataplasma'] = svg(
    path('M20 120 C100 110 220 110 300 120 L300 160 C220 150 100 150 20 160 Z', SKIN) +
    rect(120, 104, 90, 24, '#81C784', 12) + rect(110, 100, 110, 34, 'none', 8, WHITE, 3) +
    leaf(60, 60, 1.0, -30) + arrow(110, 70, 140, 96, AMBER, 3) + path('M230 50 h40 l-6 26 h-28 z', DBROWN) + line(260, 40, 245, 70, GRAY, 6))
ILL['secar_hierbas'] = svg(
    line(20, 30, 300, 30, BROWN, 6) + ''.join(line(60 + i * 70, 30, 60 + i * 70, 60, GRAY, 2) +
                                             leaf(60 + i * 70, 60, 0.9, 100) + leaf(60 + i * 70, 60, 0.9, 60) + leaf(60 + i * 70, 60, 0.8, 130) for i in range(4)) +
    rect(110, 130, 40, 50, LBLUE, 6) + rect(170, 130, 40, 50, LBLUE, 6) + rect(113, 150, 34, 26, '#A5D6A7', 4) + rect(173, 150, 34, 26, '#C5E1A5', 4))

# =====================================================================
# ORIENTACIÓN / SEÑALES
# =====================================================================
ILL['sombra_palo'] = svg(
    ground(140) + sun(40, 40, 16) + line(160, 140, 160, 70, BROWN, 6) +
    line(160, 140, 230, 150, '#000000', 6) + line(160, 140, 250, 128, '#000000', 6) +
    circle(230, 150, 8, GRAY) + circle(250, 128, 8, GRAY) + arrow(230, 150, 290, 112, AMBER, 4) +
    circle(230, 175, 6, WHITE) + circle(290, 98, 6, AMBER))
ILL['cruz_sur'] = svg(
    rect(0, 150, W, 50, '#0B1A2A', 0) + ''.join(circle(x, y, r, WHITE) for x, y, r in [(150, 30, 4), (150, 90, 5), (128, 60, 3.5), (174, 56, 3)]) +
    line(150, 90, 150, 148, AMBER, 2, '4 6') + arrow(150, 148, 150, 176, AMBER, 3) +
    ''.join(circle(40 + (i * 53) % 260, 20 + (i * 37) % 110, 1.5, GRAY) for i in range(18)))
ILL['senales_suelo'] = svg(
    rect(0, 0, W, H, '#33691E', 14) + line(40, 60, 70, 140, WHITE, 12) + line(100, 60, 70, 140, WHITE, 12) +
    line(140, 60, 200, 140, WHITE, 12) + line(200, 60, 140, 140, WHITE, 12) +
    g(path('M0 -6 L50 -6 L50 -2 L70 -14 L74 -10 L58 0 L74 10 L70 14 L50 2 L50 6 L0 6 Z', '#ECEFF1'), 220, 100) +
    g(path('M0 0 L12 -4 L30 -24 L36 -24 L28 -4 L40 -4 L46 -12 L50 -12 L46 0 L50 12 L46 12 L40 4 L28 4 L36 24 L30 24 L12 4 Z', GRAY), 250, 30, 0.9))
ILL['sos_luz'] = svg(
    rect(20, 80, 70, 40, DGRAY, 8) + poly([(90, 72), (110, 64), (110, 136), (90, 128)], GRAY) +
    '<polygon points="110,64 310,30 310,170 110,136" fill="#FFF59D" fill-opacity="0.2"/>' +
    ''.join(circle(140 + i * 22, 100, 7, YELLOW) for i in range(3)) +
    ''.join(rect(208 + i * 32, 94, 24, 12, YELLOW, 6) for i in range(3)) + '')
ILL['espejo'] = svg(
    sun(40, 40, 16) + rect(140, 120, 34, 44, LBLUE, 4, WHITE, 3) + line(54, 52, 150, 130, AMBER, 2, '6 6') + line(157, 128, 270, 40, AMBER, 3) +
    g(path('M0 0 L12 -4 L30 -24 L36 -24 L28 -4 L40 -4 L46 -12 L50 -12 L46 0 L50 12 L46 12 L40 4 L28 4 L36 24 L30 24 L12 4 Z', GRAY), 262, 40, 0.8) +
    person(110, 190, 0.7))
ILL['perdido_stop'] = svg(
    ground() + tree(40, 170, 0.9) + tree(280, 170, 1.0) +
    g(rect(-13, -40, 26, 40, SHIRT, 9) + circle(0, -54, 13, SKIN) + line(-12, 0, 18, -2, PANTS, 9) + line(12, 0, 30, 14, PANTS, 9), 150, 165) +
    path('M190 100 q10 -20 20 0 q-10 20 -20 0', 'none', WHITE, 0) + ring(200, 70, 22, WHITE, 3) + path('M193 62 q7 -10 14 0 q0 8 -7 10 v6', 'none', AMBER, 4) +
    circle(200, 86, 2.5, AMBER) + path('M230 150 C250 160 270 168 310 168', 'none', LBLUE, 6))
ILL['radio_antena'] = svg(
    path('M0 190 L120 70 L240 190 Z', '#33691E') + rect(105, 50, 30, 40, DGRAY, 6) + line(120, 50, 120, 15, GRAY, 3) +
    ''.join(path(f'M{140 + i * 16} {30 - i * 3} q12 20 0 40', 'none', AMBER, 3) for i in range(3)) + person(250, 190, 0.7))

# =====================================================================
# NUDOS / MOCHILA
# =====================================================================
ILL['as_de_guia'] = svg(
    path('M160 20 V70', 'none', AMBER, 10) + path('M160 70 C120 70 110 150 160 150 C210 150 200 70 160 70', 'none', AMBER, 10) +
    path('M150 66 C170 50 190 80 170 92 C150 104 140 80 150 66', 'none', '#FFCA28', 8) + path('M166 92 V128', 'none', AMBER, 10) +
    arrow(240, 110, 210, 110, WHITE, 3))
ILL['ballestrinque'] = svg(
    rect(145, 20, 30, 170, BROWN, 4) + path('M40 80 H160 C180 80 180 100 160 100 C140 100 140 120 160 120 C180 120 180 140 160 140 H280', 'none', AMBER, 9))
ILL['nudo_llano'] = svg(
    path('M30 100 H120 C150 100 150 70 170 80 C190 90 170 110 150 110 C130 110 140 90 170 90 C200 90 210 100 290 100', 'none', AMBER, 9) +
    path('M30 120 H120 C150 120 150 130 170 120 C190 110 200 120 290 120', 'none', LBLUE, 9))
ILL['mochila'] = svg(
    rect(110, 40, 100, 140, '#558B2F', 22) + rect(125, 110, 70, 50, '#33691E', 10) + path('M130 40 q30 -30 60 0', 'none', '#33691E', 8) +
    drop(50, 70, 0.9) + flame(50, 160, 0.6) + g(rect(-10, -24, 20, 48, GRAY, 4) + circle(0, -24, 10, YELLOW), 260, 70, 0.9) +
    g(rect(-22, -16, 44, 32, WHITE, 6) + rect(-4, -10, 8, 20, RED) + rect(-10, -4, 20, 8, RED), 262, 150))

# =====================================================================
# DESASTRES / RADIACIÓN
# =====================================================================
ILL['sismo_mesa'] = svg(
    ground() + rect(80, 90, 160, 12, BROWN, 3) + line(95, 102, 95, 170, BROWN, 8) + line(225, 102, 225, 170, BROWN, 8) +
    g(rect(-16, -30, 34, 30, SHIRT, 10) + circle(-20, -18, 12, SKIN) + line(-30, -26, -10, -34, SHIRT, 6) + line(10, 0, 30, 0, PANTS, 9), 160, 170) +
    path('M20 40 l20 10 l-10 10 l20 10 M300 40 l-20 10 l10 10 l-20 10', 'none', AMBER, 4))
ILL['inundacion'] = svg(
    path('M0 190 L160 60 L320 190 Z', '#33691E') + rect(0, 140, W, 60, '#1565C0', 14) +
    path('M0 140 q20 -10 40 0 t40 0 t40 0 t40 0 t40 0 t40 0 t40 0 t40 0', 'none', LBLUE, 4) +
    person(170, 90, 0.6) + arrow(120, 130, 150, 95, AMBER, 4))
ILL['refugio_nuclear'] = svg(
    path('M10 120 H310 V180 Q310 190 300 190 H20 Q10 190 10 180 Z', '#3E2723') +
    rect(80, 30, 160, 90, DGRAY, 2) + rect(80, 120, 160, 60, '#424242', 2) +
    ''.join(rect(90 + c * 36, 40 + r * 26, 22, 16, LBLUE, 2) for c in range(4) for r in range(3)) +
    g(rect(-12, -24, 24, 24, ORANGE, 8) + circle(0, -34, 10, SKIN), 160, 176) +
    ''.join(circle(40 + i * 40, 18 + (i % 2) * 10, 3, YELLOW) for i in range(7)) +
    check(270, 160) + cross(270, 60))
ILL['tdb'] = svg(
    ring(60, 90, 30, WHITE, 4) + line(60, 90, 60, 70, WHITE, 4) + line(60, 90, 74, 90, AMBER, 4) +
    circle(130, 140, 10, YELLOW) + arrow(145, 140, 205, 140, AMBER, 4) + person(225, 170, 0.5) +
    rect(250, 50, 24, 80, GRAY, 3) + ''.join(line(230, 60 + i * 20, 248, 60 + i * 20, YELLOW, 3) for i in range(3)) + person(295, 140, 0.5))
ILL['descontaminar'] = svg(
    g(rect(-26, -10, 52, 70, '#455A64', 8) + rect(-30, -14, 60, 10, '#263238', 4) + path('M-10 -14 q10 -16 20 0', 'none', '#263238', 4), 70, 110) +
    g(rect(-14, -40, 28, 40, ORANGE, 8), 70, 90, 0.8) + arrow(110, 100, 150, 100, AMBER, 4) +
    rect(200, 20, 50, 10, GRAY, 4) + ''.join(line(205 + i * 10, 34, 205 + i * 10, 80, LBLUE, 3, '6 6') for i in range(5)) +
    person(225, 185, 0.9, SKIN))

# =====================================================================
# RECONSTRUIR
# =====================================================================
ILL['letrina'] = svg(
    ground(130) + path('M60 130 h50 v50 h-50 z', '#3E2723') + rect(52, 70, 66, 60, BROWN, 4) + poly([(46, 74), (85, 50), (124, 74)], DBROWN) +
    path('M200 140 q20 -10 40 0 t40 0 v20 h-80 z', BLUE) + arrow(130, 110, 190, 110, AMBER, 3) + arrow(190, 110, 130, 110, AMBER, 3) +
    ''.join(circle(150 + i * 10, 95, 2.5, AMBER) for i in range(3)))
ILL['milpa'] = svg(
    ground() + line(160, 170, 160, 40, '#9CCC65', 6) + leaf(160, 120, 1.0, -30, '#9CCC65') + leaf(160, 90, 1.0, 210, '#9CCC65') +
    rect(166, 70, 14, 30, YELLOW, 6) + path('M160 160 C130 140 190 120 160 100 C130 80 190 60 160 40', 'none', DGREEN, 3) +
    ''.join(circle(150 + (i % 2) * 20, 140 - i * 20, 5, '#4E342E') for i in range(4)) +
    circle(230, 160, 18, ORANGE) + leaf(210, 165, 0.9, -10) + leaf(90, 165, 0.9, 190) + circle(90, 160, 14, ORANGE))
ILL['compost'] = svg(
    ground() + path('M70 170 C80 100 240 100 250 170 Z', '#4E342E') + path('M90 150 C110 120 210 120 230 150', 'none', '#795548', 10) +
    path('M100 130 C120 110 200 110 220 130', 'none', GREEN, 8) + leaf(140, 110, 0.5, -60) + circle(180, 115, 6, RED) +
    path('M260 60 q-10 20 0 40 q10 20 0 40', 'none', AMBER, 3) + arrow(270, 120, 250, 150, AMBER, 3))
ILL['huerta'] = svg(
    sun(270, 35, 14) + ground() + rect(30, 140, 120, 30, '#5D4037', 6) + rect(170, 140, 120, 30, '#5D4037', 6) +
    ''.join(leaf(45 + i * 22, 140, 0.45, -70) + leaf(45 + i * 22, 140, 0.45, 250) for i in range(5)) +
    ''.join(line(185 + i * 24, 140, 185 + i * 24, 110, GREEN, 3) + circle(185 + i * 24, 108, 7, RED) for i in range(5)) +
    path('M40 70 q20 -20 40 0', 'none', LBLUE, 0))
ILL['semillas'] = svg(
    ''.join(rect(40 + i * 90, 60, 60, 100, LBLUE, 10) + rect(46 + i * 90, 50, 48, 14, GRAY, 4) +
            ''.join(circle(55 + i * 90 + (k % 4) * 10, 140 - (k // 4) * 10, 4, c) for k in range(16))
            for i, c in enumerate([YELLOW, '#4E342E', ORANGE])))
ILL['respiracion_caja'] = svg(
    rect(100, 40, 120, 120, 'none', 10, AMBER, 5) + arrow(110, 40, 210, 40, WHITE, 3) + arrow(220, 50, 220, 150, WHITE, 3) +
    arrow(210, 160, 110, 160, WHITE, 3) + arrow(100, 150, 100, 50, WHITE, 3) + circle(160, 100, 22, SKIN))
ILL['grupo'] = svg(
    ground() + person(80, 170, 0.8, ORANGE) + person(130, 170, 0.9, SHIRT) + person(185, 170, 0.85, GREEN) + person(240, 170, 0.8, PURPLE) +
    flame(160, 196, 0.4))

# =====================================================================
os.makedirs(OUT, exist_ok=True)
for name, content in ILL.items():
    with open(os.path.join(OUT, name + '.svg'), 'w', encoding='utf-8') as f:
        f.write(content)
print(len(ILL), 'ilustraciones en', os.path.abspath(OUT))
