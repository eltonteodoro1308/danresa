#include 'totvs.ch'

user function axCadZZZ()

	Local cAlias := "ZZZ"

	Private cCadastro := "Produto Nectar x Protheus"
	Private aRotina := {}

	AADD(aRotina,{"Pesquisar" ,"AxPesqui",0,1})
	AADD(aRotina,{"Visualizar" ,"AxVisual",0,2})
	AADD(aRotina,{"Incluir" ,"AxInclui",0,3})
	AADD(aRotina,{"Alterar" ,"AxAltera",0,4})
	AADD(aRotina,{"Excluir" ,"AxDeleta",0,5})

    chkfile( cAlias )

	dbSelectArea(cAlias)
	dbSetOrder(1)

	mBrowse(6,1,22,75,cAlias)

Return



