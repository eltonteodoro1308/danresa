#include 'totvs.ch'

user function MT410ROD()

	Local nX      := 0
	// Local oGetDad := PARAMIXB[1]

    /*
    PARAMIXB[1]			Objeto			Objeto do rodape do pedido de venda.						X				
    PARAMIXB[2]			Caracter		Descrição do cliente/fornecedor						X				
    PARAMIXB[3]			Numérico		Valor bruto do pedido de venda.						X				
    PARAMIXB[4]			Numérico		Valor do desconto/acrescimo						X				
    PARAMIXB[5]			Numérico		Valor liquido do pedido de venda.						X
    */

	// aSize( oGetDad:aCols, 0 )

	for nX := 1 to len( aSC6 )

		if nX > 1

			oGetDad:AddLine(.T.)

		end if

		GDFieldPut( 'C6_PRODUTO', aSc6[nX]['PRODUTO'             ], n, aHeader , aCols )
		GDFieldPut( 'C6_QTDVEN' , aSc6[nX]['QUANTIDADE'          ], n, aHeader , aCols )
		GDFieldPut( 'C6_PRCVEN ', aSc6[nX]['VALOR_UNITARIO'      ], n, aHeader , aCols )
		GDFieldPut( 'C6_XOPORTU', aSc6[nX]['OPORTUNIDADE'        ], n, aHeader , aCols )
		GDFieldPut( 'C6_XCOPORT', aSc6[nX]['CLIENTE_OPORTUNIDADE'], n, aHeader , aCols )
		GDFieldPut( 'C6_LJOPORT', aSc6[nX]['LOJA_OPORTUNIDADE'   ], n, aHeader , aCols )
		GDFieldPut( 'C6_XITOPOR', aSc6[nX]['ITEM_OPORTUNIDADE'   ], n, aHeader , aCols )

		oGetDad:LinhaOk(.T.,.T.)

	next nX

return
