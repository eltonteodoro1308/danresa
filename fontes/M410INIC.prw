#include 'totvs.ch'

user function M410INIC()

	Local nPos := 0
	Local nX := 0

	M->C5_CLIENTE := jSC5['CLIENTE']
	M->C5_LOJA    := jSC5['LOJA']

	for nX := 2 to len( aSC6 )

		aAdd( aCols, aClone( aCols[1] ) )

		aCols[ nX, aScan( aHeader, {|item| alltrim(item[2]) == 'C6_ITEM' }) ] := strZero( nX, tamSx3('C6_ITEM')[1] )

	next nX

	for nX := 1 to len( aSC6 )

		aCols[ nX, aScan( aHeader, {|item| alltrim(item[2]) == 'C6_PRODUTO' }) ] := aSc6[nX]['PRODUTO']
		aCols[ nX, aScan( aHeader, {|item| alltrim(item[2]) == 'C6_QTDVEN'  }) ] := aSc6[nX]['QUANTIDADE']
		aCols[ nX, aScan( aHeader, {|item| alltrim(item[2]) == 'C6_PRCVEN ' }) ] := aSc6[nX]['VALOR_UNITARIO']
		aCols[ nX, aScan( aHeader, {|item| alltrim(item[2]) == 'C6_XOPORTU' }) ] := aSc6[nX]['OPORTUNIDADE']
		aCols[ nX, aScan( aHeader, {|item| alltrim(item[2]) == 'C6_XCOPORT' }) ] := aSc6[nX]['CLIENTE_OPORTUNIDADE']
		aCols[ nX, aScan( aHeader, {|item| alltrim(item[2]) == 'C6_LJOPORT' }) ] := aSc6[nX]['LOJA_OPORTUNIDADE']
		aCols[ nX, aScan( aHeader, {|item| alltrim(item[2]) == 'C6_XITOPOR' }) ] := aSc6[nX]['ITEM_OPORTUNIDADE']

	next nX

return
