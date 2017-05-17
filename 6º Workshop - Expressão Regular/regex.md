# Seminário - Regular expression

_Some people, when confronted with a problema, think "i know, I'll use regular expressions." Now they have two problems._  
_`Jamie Zawinski. 1997`_

## O que é regex? 

A Expressão Regular é a realidade subjetiva da nossa intuição interna para identificar padrões em relação a computação, reaproveitando-se do conhecimento "a priori" e evitando o uso desnecessário da regressão linear para atingir o objetivo proposto. Ou seja, criamos uma representação abstrata da forma que queremos extraí, concebendo uma nova forma pura do Objeto sintético, sensível a nossa intuição e capacidade de abstração. Portanto, Expressão Regular limita-se ao seu entendimento.

Fonte: Angelim

> Regex é que nem c[a-z]\b, cada um tem o seu!

_"A **_expressão regular_** provê uma forma concisa e flexível de identificar cadeias de caracteres de interesse, como caracteres particulares, palavras ou padrões de caracteres. Expressões regulares são escritas numa linguagem formal que pode ser interpretada por um processador de expressão regular, um programa que serve um gerador de analisador sintático ou examina o texto e identifica as partes que casam com a especificação dada."_

Fonte: [Wikipedia](https://pt.wikipedia.org/wiki/Express%C3%A3o_regular)

## Sintaxe e Regras

A norma [IEEE POSIX 1003.2 (POSIX.2)](http://standards.ieee.org/findstds/interps/1003-2-92_int/) padroniza a semântica, baseando-se na notação de caracteres primitivos/metacaracteres.

Tabela 1: ` Expressões regulares básicas e extendidas `

| Metacaractere| Descrição  |
|:------------:|:----------|
| ***.***      | Qualquer caractere  |
| ***[ ]***    | Lista de caracteres |
| ***[^ ]***   | Negação da lista de caracteres |
| ***^***      | Âncora que simboliza o início da cadeia de caracteres |
| ***$***      | Âncora que simboliza o fim da cadeia de caracteres    |
| ***( )***    | Captura uma subexpressão de caracteres |
| ***\n***     | Representa a n-éssima subexpressão de caracteres capturada |
| ***\****     | Quantificador do caractere precedente, representando-o de 0-N |
| ***{m, n}*** | Quantificador do caractere precedente, representando-o de M até N |
| ***?***      | Quantificador do caractere precedente, representando-o de 0-1 |
| ***+***      | Quantificador do caractere precedente, representando-o de 1-N |
| ***\|***     | Ou lógico |

Tabela 2: ` Classes de caracteres`

> Uma classe representa um padrão para um conjunto de expressões regulares

| Classe |  Grupo  |
|:------:|:--------|
| ***[:alnum:]***  | [a-zA-Z0-9] |
| ***[:alpha:]***  | [A-Za-z]    |
| ***[:blank:]***  | [ \t]       |
| ***[:digit:]***  | [0-9] ou \d |
| ***[:lower:]***  | [a-z]       |
| ***[:upper:]***  | [A-Z]       |
| ***[:>:]***      | Fim da palavra |
| ***[:<:]***      | Início da palavra |

Tabela 3: ` Olhar em volta`

## Exemplos:

Tenha cuidado com o metacaractere ***.*** (ponto final) durante a fase de criação.

### Perl - Exemplos

|  Classe           | Descrição |
|:-----------------:|:----------|
|***(?=pattern)***  | Mostra o que está antes da classe, somente se, a entrada e a expressão regular casarem |
|***(?!pattern)***  | Mostra o que está antes da classe, somente se, a entrada e a expressão regular não casarem |
|***(?<=pattern)*** | Mostra o que está depois da classe, somente se, haver combinação entre a entrada e a expressão regular |
|***(?<!pattern)*** | Mostra o que está depois da classe, somente se, não haver combinação entre a entrada e a expressão regular |

> O Perl implementa uma semântica mais consistente e rica que o padraão `POSIX`, assim como foi a principal ferramenta que impulsionou o Regex.

Exemplo 1: ` ./seminario.pl --search '[sX][eE3][Xx][oO0]'`
```
020f8020  42 52 2d 31 36 35 31 33  34 73 33 78 30 38 37 34  |BR-165134s3x0874|
1556dd70  1e 09 ad 3c ea eb 43 d0  73 33 78 4f 19 0c 0c 9b  |...<..C.s3xO....|
```

Exemplo 2: ` ./seminario.pl --search 'V[a-zA-Z]{5}(?=\.)'`
```
081173a0  ae 3f 04 05 46 ca 8e 9c  f0 56 45 49 4e 77 75 c9  |.?..F....VEINwu.|
08253390  c3 1e 13 66 56 64 56 69  71 70 8e f1 d9 7c 1f 5f  |...fVdViqp...|._|
08845240  37 a6 52 c6 af 33 56 73  76 4f 51 62 1b 0e 5d 6a  |7.R..3VsvOQb..]j|
088df8b0  34 28 56 71 4e 4f 54 46  e5 47 21 e9 f0 89 71 51  |4(VqNOTF.G!...qQ|
08b9ec90  0e 51 9e e6 56 61 76 6e  4e 50 81 11 4c c1 3f 40  |.Q..VavnNP..L.?@|
08bfed40  fc 23 06 a2 0a 1c 05 e7  56 70 56 45 50 52 ac 4b  |.#......VpVEPR.K|
08e4bb60  75 e2 1e e2 56 43 45 6f  72 7a 1b ea 2b 05 eb 82  |u...VCEorz..+...|
08ef6280  8e 8f 38 56 53 48 5a 4b  47 b3 2b 66 6a 84 4a 53  |..8VSHZKG.+fj.JS|
```

Exemplo 3: ` ./seminario.pl --search '(BR-|[a-zA-Z]+\.mp4)'`


```
020f8020  42 52 2d 31 36 35 31 33  34 73 33 78 30 38 37 34  |BR-165134s3x0874|
020f8030  36 35 34 2d 48 44 2e 6d  70 34 72 74 68 5f 45 64  |654-HD.mp4rth_Ed|
020f8050  b4 0f 16 01 42 52 2d 31  36 35 31 33 34 38 37 34  |....BR-165134874|
020f8060  36 35 34 2d 48 44 2e 6d  70 34 00 00 00 00 00 00  |654-HD.mp4......|
```

Exemplo 4: ` ./seminario.pl --search '(Voice(?=\.)|[a-zA-Z]+\.mkv)'`
```
020f0030  5c 00 37 01 56 6f 69 63  65 2e 66 72 6f 6d 2e 74  |\.7.Voice.from.t|
020f0060  53 68 41 61 4e 69 47 2e  6d 6b 76 00 0d 00 00 00  |ShAaNiG.mkv.....|
08801060  73 6b 61 20 76 31 2e 34  2e 32 57 41 c1 6d 6b 76  |ska v1.4.2WA.mkv|
```

### Python - Exemplos

> O Python adota a sintaxe do Perl

No python o padrão de expressão regular é suportado pela biblioteca ***re***


Exemplo 1: ./seminario.py -s 's3x0'  
```
['s3x0']
```

Exemplo 2: ./seminario.py -s '[sX][eE3][Xx][oO0]'
```
['s3x0', 's3xO']
```

Exemplo 3: ./seminario.py -s 's[0-9a-zA-Z]x[:alnum:]'
```
['ssxu', 'shxl', 'sVxm', 's3xl', 'sRx:', 'snxl', 'slx:', 's9xa', 'sqxu', 'sTxn', 'sgx:', 'smxm', 's2xn', 'sMxl', 'slxn', 's8xl', 's8xl', 'sYx:', 'saxu', 'snxn', 'sBxm', 'sOxm', 's6
xa']
```

Exemplo 4: ./seminario.py -s 's[0-9a-zA-Z]x[0-9a-zA-Z]'  
```
['s3x0', 'ssxu', 'sFx4', 'sQxc', 'scxU', 's3xx', 'sMxw', 's7x0', 's8xq', 'sDxi', 'sdxt', 'sZxN', 'sjxZ', 'sLxH', 'shxl', 's4xY', 's1xN', 'sJx4', 's7xc', 'smxh', 'svxC', 's0xw', 'sk
xS', 'sQxe', 's6xK', 'sDxr', 'sfxG', 'sSx6', 'sqx6', 'skxS', 'sVxm', 'suxh', 'sDxK', 's0xt', 'sSx7', 'sjxH', 'sbxj', 'swxj', 'soxN', 'sFxi', 'sexC', 'slxi', 'sZxt', 'sTxG', 's8xs',
 'shxP', 'smxO', 'sixU', 'scxd', 'sMxN', 's3xz', 's5xM', 'srxw', 'sJxz', 's3xl', 'sjxQ', 'sUxx', 'sZx2', 'sRxH', 'sbxH', 'snxl', 'svxx', 'sYxh', 'sGxR', 'soxw', 'spxI', 'sgxj', 'sy
xC', 's6xB', 'syx7', 'sxxj', 'smxZ', 's6xD', 'sExT', 'sPxJ', 'sXxM', 'soxR', 'smxZ', 's9xa', 'slxq', 'slxf', 's5xb', 'spxD', 's5xz', 'six0', 'sDxQ', 'stxO', 'sgxq', 'sxxS', 'szxb',
 'sNxd', 's7xk', 'sJxT', 'sbxW', 's0xO', 'sAxx', 'saxr', 'sAxp', 'ssxK', 's4xy', 'sAxt', 'svxU', 'sixA', 'sqxu', 'sFx9', 'sTxy', 'sCxr', 's0xG', 'sqxg', 'snxk', 'sTxn', 'sMxT', 'sd
xG', 's3xv', 'sjxP', 's9xx', 's3x2', 'sfx2', 'sUxJ', 's4xh', 'smxm', 'sXx4', 'sTxz', 'sdxz', 'sExR', 's5xy', 'sDxU', 'sTx2', 'sWx1', 's7xU', 'sQxK', 'szxt', 'sDxO', 'sVxx', 's2xn',
 'sQx7', 's1xo', 'sgxD', 's7x0', 'sRxc', 'spx2', 'sHxE', 'sMxl', 'sox5', 'stx1', 'slxT', 'sIx4', 'slxn', 's5x1', 'sHxp', 'sZxQ', 'sexC', 'sQxB', 's5xA', 'szx2', 's6xr', 'sUxY', 'sg
xT', 'srxU', 'suxN', 's5xJ', 'sUx5', 'scxL', 'sHxX', 'swxB', 'sYxp', 'spx2', 's9xz', 'scxx', 's3xO', 's8xz', 'sNx0', 'sgxv', 's9xo', 'sBx2', 'soxE', 'sdxE', 'sTxS', 'sqxk', 's5xb',
 'stx1', 'sUxg', 's8xg', 'sExz', 's1xg', 'sXxo', 'sMxw', 'sUxC', 'slxo', 'sSxd', 's6xt', 's8xl', 'sRxQ', 's2xB', 'sBx1', 'sExe', 's7xX', 'snx1', 'sCx9', 'sixf', 'sex8', 'sox7', 'se
xe', 'smxt', 's8xl', 'sIxE', 'sNxf', 'sqx5', 'sLxC', 'szxw', 'sQxU', 's8x7', 'sbxI', 'sbxB', 'sSxe', 'sPxB', 'sGxd', 'ssxG', 'smxE', 'sFxX', 's1xj', 'smxj', 'slxo', 'sUxW', 'sMx3',
 'sUxk', 'sExW', 'sDxS', 'sexx', 's1xw', 's9x9', 'sbxQ', 'sSx2', 'sDx0', 'sTxr', 'sxxv', 'sCx5', 'stxF', 'sXx6', 'sexg', 'sOxX', 'sVxH', 'scxG', 'suxZ', 's6xQ', 'sNx5', 'sUxd', 'sd
x0', 'scx1', 'sUxt', 'sKx6', 'sAxQ', 'sixi', 'saxu', 'snxn', 'sIx3', 'sAxp', 'sZx1', 'sxxD', 's9xj', 'sBxm', 'sGxJ', 'snxk', 'sUxK', 'sVx9', 'sDxS', 'stxS', 'sxxr', 'sqxP', 'sox8',
 'ssxP', 'stxE', 'swxZ', 's9xo', 's4xF', 'szxD', 'sMxL', 'slxq', 'sJxp', 's5xB', 'smxC', 'sOxR', 'sDxe', 'sJxV', 'sbxY', 'soxc', 's5xC', 's6xh', 'sHxZ', 'ssxS', 'sQx7', 'sMxw', 'sT
x5', 'sMxi', 's0xZ', 'sTxL', 'slxy', 'swxW', 'slxP', 'sOxm', 'sdxK', 'soxq', 'sgxN', 'smxo', 'sUxh', 'svxA', 'sjx6', 's0xp', 's3xz', 's6xa', 'szx1', 'sJxd', 'sYxf', 'slxf', 'sGx8',
 's7xW']
 ```

 ./seminario.py -s '[a-zA-Z]+\.mp4'
 ```
['HD.mp4', 'HD.mp4', 'N.mp4', 'yF.mp4']
```

./seminario.py -s 'V\w{5}(?=\.)'
```
['V___XX', 'VEINwu', 'VK7IYX', 'VdViqp', 'VfU6QH', 'VT3yet', 'VsvOQb', 'VqNOTF', 'VDq5FG', 'VMv1iL', 'V8w0iy', 'Vd3fdz', 'VavnNP', 'VpVEPR', 'Vk8pKJ', 'VoLD38', 'V3XJm2', 'VCEorz',
 'VSHZKG', 'Vk0Uv1', 'VVRqy_', 'V3H9hn', 'VJEheU', 'VoDm_p', 'VeYWCS', 'VhN0B1', 'VV55fy', 'V7koUE', 'VZ7Hnc', 'VsHwmG', 'VkRkEc', 'VXoYaH', 'VApvrj', 'Vkh7EW', 'VDGFNl', 'VXBXhL',
 'VXVNDH', 'VERkrm', 'V_3ZG0', 'VOGG3L', 'V3mwgO', 'VUpcnA', 'Vaqctt', 'VpPc2A', 'VLT7jx', 'ViShgy', 'VOFTOA', 'Vkelcy', 'VZFJUo', 'VKbl_4', 'Va1Y5l', 'VHdf2i', 'Vn7r6K', 'VtJpSn',
 'V2IpnD', 'ViwZ6Y', 'VIC7GB', 'Vkt5NB', 'V8KtDn', 'VJM_2e', 'VFL7KX', 'VKpK3k', 'VPWacY', 'VMRkYF', 'V_WLF_', 'Vt1jq6', 'VxOMp2', 'V2Gsn1', 'V2OZud', 'V667aF', 'V5VU_J', 'VInAeZ',
 'VVRm1r', 'VrH6Zm', 'VD_FAO', 'V91stC', 'V1KPpj', 'Vvmz0N', 'V7bpA_', 'VaWgoW', 'VqrihH', 'VWnwZ9', 'VBWhZW', 'VRDIPZ', 'Vm0dQ7', 'V0QgkI', 'VcEnJB', 'VH58oL', 'VU1H55', 'VzVvuJ',
 'Vo80PX', 'VDDJYj', 'VzAu0X', 'Vx_w3L', 'VyCwWU', 'VFuUih', 'ViL5hR', 'Vr1tgf', 'VIJeGs', 'Vlq4pv', 'VAGVjs', 'VG7tNL', 'VDKSTq', 'VPjMoc', 'VsfUDg', 'V9Wjis', 'VTNv8f', 'V3LRbK',
 'Vb9fA0', 'Vs7KI3', 'VRwbiT', 'V2RyTZ', 'VCj8SQ', 'VRC902', 'Vwpz0S', 'Vrtgbw', 'VjRMok', 'VT80eM', 'VYwb2m', 'VR6CVW', 'V0RslQ', 'VojgIe', 'VhKBZ_', 'VbxCBI', 'VlFzhD', 'VsHpB9',
 'VhKp30', 'VZDR4u', 'Vd3Psp', 'Vi9hcI', 'VUNGSB', 'VEqpUu', 'VPaPbU', 'Vq4sT_', 'Vum20c', 'V2Tru7', 'VSoIPX', 'V9TX9i', 'V6x5ke', 'V4yxBY', 'VTgFb5', 'VWnHWp', 'VE6WZt', 'VE1gzm',
 'Vo7RDT', 'VcNwmh', 'VP5TyR', 'VyTtMi', 'VUec5w', 'V_rgvt', 'VRRmOg', 'VxV_0Q', 'VQnRsK', 'VKv_MQ', 'VbSLwM', 'Vnd2NB', 'Vnd_4w', 'V4zuKm', 'Vz7pi5', 'V9nRbD', 'VgaXkc', 'Vkw4ca',
 'V9FvD2', 'Vyz4Im', 'Vh6TED', 'Vpio_B', 'VRqCb6', 'VUBURf', 'VvOSS8', 'V3J8cR', 'VECPNo', 'VROcEI', 'VjG232', 'VPi1CV', 'VZBGTS', 'VqdPpz', 'VJebY5', 'VmDFyT', 'VpKV88', 'V_GYUu',
 'V5TKjN', 'VwWFwl', 'VksBmY', 'V3nGUp', 'V4LWqv', 'VeV1Bj', 'VgEVaA', 'VkgOrS', 'VhIqQb', 'VcE4ve', 'VOLNW8', 'Vjii_b', 'Vplu0E', 'Vi9x3l', 'Va0XXP', 'VE2Ky8', 'VAchxc', 'VzP65A',
 'V23e2O', 'VCXvll', 'V4y7eh', 'VMdBA4', 'VSQ7r5', 'ViBVCO', 'V9AYVt', 'VYMjTE', 'VHuXAx', 'V0g9Ck', 'VUDMdv', 'V2Vbnv', 'VjExUp', 'VxlxX4', 'VkOJXw', 'Ven5E2', 'VVPTZv', 'VmElDN',
 'V6yXzO', 'VmhNaH', 'VRmm60', 'VKiffk', 'V3coh_', 'VMibSt', 'VDvsvX', 'VIFZ9z', 'VQ2NWg', 'V4aLyP', 'VhY_BN', 'V7kKZm', 'VIDtx0', 'VkXxIj', 'VUSmQ9', 'Va0dLh', 'VMUy8k', 'ViOH4p',
 'VB1A3W', 'VoWI9w', 'Vx3QRs', 'Vv0U3W', 'VNz50m', 'VDhOu4', 'VTkumQ', 'VIvlht', 'VfvDaJ', 'VhcTal', 'VvO6Lm', 'Vm9CvC', 'VoggDq', 'VnvN6q', 'VA9leq', 'VI9G3T', 'VmFcKv', 'VvTmB1',
 'V42S0H', 'VvaKcf', 'VLWfIS', 'VTYzkD', 'VXGnrW', 'V2Mzn6', 'VFvDy4', 'VnTEiP', 'V_l7Qh', 'VsB1z7', 'V_qnVo', 'Vb5Mj_', 'VD1_Go', 'Vg0lMC', 'V0oa8f', 'Vgv6G9', 'V0wnCy', 'VF1SR9',
 'VmJ0YJ', 'VvqWQp', 'VxYyQ9', 'Vt6N0D', 'VaQSUA', 'VidFgw', 'VvQ13J', 'VfdpM8', 'V_L2k9', 'VOZlAg', 'VqS79l', 'VtXsuC', 'V_zfXz', 'VtH_gL', 'VNXvM0', 'VXygEJ', 'VvTjiV', 'Vf9wpR',
 'V8Bl9C', 'VA0hPx', 'VupSy7', 'VhkfpY', 'VNTS7X', 'V7b924', 'Ve0fgT', 'VQEvhr', 'VCzEeX', 'VjSEdR', 'Vy13mD', 'VKRX1q', 'VuNCHW', 'VdhmFu', 'V4S24K', 'VfYMZq', 'VklWas', 'VS0miF',
 'VAcRTH', 'V1fzZD', 'V6MwV7', 'VuNVtG', 'V58MjW', 'V3LrXq', 'VcbEce', 'VBijMm', 'VV05QA', 'Visi89', 'VwPYLL', 'VdyuNV', 'V5Sy4b', 'V1MCBL', 'VR7Nej', 'VmYduB', 'V2jQSC', 'VZSqoL',
 'VtfgvC', 'VVIee0', 'VRbHeu', 'V4upt_', 'VzhvMW', 'VapH1N', 'VLM_FZ', 'Vus7EA', 'VVlWm6', 'VwnT60', 'VP2_kg', 'VzWKrp', 'V6gyC_', 'VH1MtR', 'VjUlUU', 'Vz0Qgf', 'VAIlJQ', 'VXCtdn',
 'VS8xRA', 'VO4GKI', 'VaOdnj', 'Vh2ns7', 'VPfpXu', 'VZEidX', 'VxlOxC', 'Vn4ixH', 'VIwlEs', 'VrXv2w', 'V_R7NV', 'VNhbRZ', 'VDhmXx', 'VYfcSP', 'VcOvsE', 'VuNLJ0', 'VfBz1n', 'VF1sfj',
 'VbxK1d', 'VPn7ij', 'VpnnlL', 'V4sGO5', 'VnnJAj', 'VplVK0', 'VfSWA1', 'VnQlzb', 'V2hz9T', 'VWfQzS', 'V7Q6Yx', 'Vgoixs', 'VbugeO', 'VT5DtJ', 'VeFU_1', 'V8Ncgr', 'VHCRiu', 'Vuy7D0',
 'V6lZ5Z', 'V1_RPj', 'VBCRcd', 'V6rpfL', 'VolnEe', 'VEYUSH', 'Vnh5UT', 'VZsvPR', 'V2v5ww', 'V0yblS', 'V8KG9j', 'VA_LiZ', 'VO_kEN', 'VOFLHC', 'V3yLrV', 'VaezTD', 'VAf5Wq', 'VLyKIZ',
 'VmG3bB', 'VLSrar', 'VXK791', 'VrxTIa', 'VQKrNf', 'VpxiV8', 'V6yBlw', 'VDCsf2', 'V3Bgme', 'VnIaV0', 'V5UxtV', 'Vv95Qe', 'VyfnNu', 'VWbW97', 'VmoB1i', 'V03lBU', 'VBypMS', 'VOujfn',
 'VxAkEc', 'VVgsUm', 'VDfyOb', 'VFwwn8', 'VOoGrA', 'Vocvb4', 'VeoWpy', 'V1j_qk', 'VjMzVq', 'V3pFy1', 'VWbqLm', 'Vb8G8m', 'V3ww0t', 'VHzhvy', 'V3yeeY', 'VsB86l', 'Vk9hbs', 'VNL3G5',
 'Vwfzi9', 'V1F2_N', 'VZemVX', 'VEJ_Wm', 'V9U_Yc', 'V_F_5V', 'V0A29j', 'VZLSYR', 'Vey7nL', 'VdtcB0', 'VnBdct', 'VJIzl6', 'V7h9JY', 'Vl0zhH', 'VS97cC', 'VnG8qr', 'V3gdNy', 'V83bpv',
 'VqmKBY', 'VLtV3l', 'VXmD0O', 'Vtllz7', 'VxSnJs', 'VmLNFE', 'VvOiBo', 'VEUWP4', 'VI3Ymt', 'V3QjMX', 'VlhMPY', 'VRJmn5', 'V3TKN0', 'VpmjIT', 'VNp8a0', 'VXkQ2x', 'V9UO35', 'VTDIzI',
 'VxPpll', 'V7U5bI', 'VfvYKU', 'VeK85x', 'V_Osr1', 'VT7bzx', 'VTm_0P', 'VM9m5K', 'VHDWUf', 'VcER6x', 'Vf_p10', 'V9STwy', 'VsXXss', 'VKcBFR', 'VP5NwS', 'ViXjfS', 'VLnN8B', 'V_eZdK',
 'VxNpqB', 'Vahl2A', 'V2ml8L', 'V2AYDA', 'VlgawA', 'VOjhV7', 'VVDqjQ', 'VIKP6R', 'VC7s10', 'VFmp_5', 'VQEn8I', 'VR7AVF', 'VwFVcu', 'VO9tnK', 'V0sOXJ', 'VZ_2v9', 'VbDjcZ', 'VQFLA6',
 'VRCv9i', 'VvwyR4', 'VPqlD0', 'VeaSqw', 'V3TdtL', 'VDyzcV', 'VqzX_v', 'VGEUSB', 'VSYzh4', 'VTp6FV', 'VcMGji', 'VfOoAX', 'V_kN4e', 'VuHo6N', 'VWepNY', 'VmfDCQ', 'VXv8_3', 'VhwxBB',
 'VcobLq', 'VnsA4m', 'VrwG3u', 'VN_S5r', 'VALB0R', 'V3Gbn3', 'VPybbV', 'VdaUT3', 'ViUuwh', 'VQtzNN', 'VLbsEs', 'VamAMB', 'VdExct', 'VvZSMz', 'VCQhI6', 'VOEF9A', 'VAxg9t', 'VNOjms',
 'VnLHKz', 'VrGbdS', 'VL1Hlm', 'VJZgEU', 'VKcCCB', 'VVp8EK', 'VMeHFy', 'VPh3zT', 'VwN7y_', 'V6UI50', 'VUhcOj', 'VvIHJP', 'VNBGbI', 'Vpv8st', 'V8DZrq', 'VuLAcb', 'V0bu0R', 'V4tbe8',
 'VFo3sN', 'VV7dvb', 'V9co5p', 'VSNgMc', 'V32ifA', 'Vpr9OR', 'VZFRqt', 'V3tE3j', 'VQZ2jq', 'V6QZ1U', 'VzIO8D', 'Vfq7bT', 'VenUFh', 'VYaTqa', 'V5Gaz8', 'VncaVB', 'V6EaJ5', 'VFiFAG',
 'VbjBUJ', 'VbKg6g', 'VBcE9b', 'VDu7jh']
 ```

 ## Código fonte

 Filename: ` seminario.pl`

 ```perl
#!/usr/bin/perl
# Autor: Enilton Angelim
use strict;
use warnings;
use Getopt::Long qw(GetOptions);
use Path::Tiny;
use autodie;

my $dir = path("./");

my $file = $dir->child("pendrive_filesystem.dump");

sub blob {
    return $file->openr_utf8();
}

sub search {
    my $pattern = $_[0];
    my $content = blob();
    while( my $line = $content->getline() ) {
       $line =~ /$pattern/ and print $line;
    }
}

my $pattern;
GetOptions('search=s' => \$pattern) or die "Usage: $0 --search PATTERN\n";
if($pattern) {
    search($pattern)
}
 ```


Filename: ` seminario.py`

```python
#!/usr/bin/python3
# -*- coding: utf-8 -*-
# Autor: Enilton Angelim

import re
from optparse import OptionParser

def blob():
    return open('pendrive_filesystem.dump', 'r').read()

def search(pattern):

    """ Seminario de seguranca
        Metodo para pesquisa do padrao regex
    """

    pattern = re.compile(r'{}'.format(pattern))
    print(pattern.findall(blob()))


if __name__ == '__main__':

    parser = OptionParser()
    usage = "usage: %prog [options] arg1"
    parser.add_option("-s", "--search", type="string",
        help="-s string, --search string",
        dest="pattern", default=".*")
    (options, args) = parser.parse_args()

    search(options.pattern)
```
