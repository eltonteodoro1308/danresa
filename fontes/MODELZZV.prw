#include 'totvs.ch'
#include 'fwmvcdef.ch'

static function modelDef()

	local oModel  := mpFormModel():new('MODELZZV')
	Local oStruct := FWFormStruct( 1, 'ZZV')

	oModel:AddFields( 'MASTER',, oStruct )
	oModel:SetDescription( 'Produtos Nectar' )
	oModel:GetModel( 'MASTER' ):SetDescription( 'Produtos Nectar' )

return oModel

static function viewDef()

	Local oModel  := modelDef()
	Local oStruct := FWFormStruct( 2, 'ZZV')
	Local oView   := FWFormView():New()

	oView:SetModel( oModel )
	oView:AddField( 'VIEW', oStruct, 'MASTER' )
	oView:CreateHorizontalBox( 'TELA' , 100 )
	oView:SetOwnerView( 'VIEW', 'TELA' )

return oView
