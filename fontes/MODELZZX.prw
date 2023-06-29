#include 'totvs.ch'
#include 'fwmvcdef.ch'

static function modelDef()

	local oModel  := mpFormModel():new('MODELZZX')
	Local oStruct := FWFormStruct( 1, 'ZZX')

	oModel:AddFields( 'MASTER',, oStruct )
	oModel:SetDescription( 'Contatos Nectar' )
	oModel:GetModel( 'MASTER' ):SetDescription( 'Contatos Nectar' )

return oModel

static function viewDef()

	Local oModel  := modelDef()
	Local oStruct := FWFormStruct( 2, 'ZZX')
	Local oView   := FWFormView():New()

	oView:SetModel( oModel )
	oView:AddField( 'VIEW', oStruct, 'MASTER' )
	oView:CreateHorizontalBox( 'TELA' , 100 )
	oView:SetOwnerView( 'VIEW', 'TELA' )

return oView
