#include 'totvs.ch'

/*/{Protheus.doc} B0828000
Relatório de carregamento exportação.
@type function
@version  1.0
@author Maycon Motta
@since 
/*/
user function B0828000()

    local oReport as object
    private cAliasRep  as character
    private dDtCargIni as date
    private dDtCargFim as date
    private cCodEmbIni as character
    private cCodEmbFim as character
    private cLojEmbIni as character
    private cLojEmbFim as character
    private cCodTraIni as character
    private cCodTraFim as character
    private cCodArmIni as character
    private cCodArmFim as character
    private cCodDstIni as character
    private cCodDstFim as character
    private cCodPrdIni as character
    private cCodPrdFim as character 
    private cCodNavIni as character
    private cCodNavFim as character
    private cModal     as character   


    If FindFunction("VERSAOGT")
        SetKey(K_CTRL_F12, {||VERSAOGT()})
    Else
        SetKey(K_CTRL_F12, Nil) 
    EndIf

    if parametros()

        cAliasRep := getNextAlias()
        oReport := reportDef()
        if oReport == Nil
		    return
	    endif

        oReport:PrintDialog()

    endif

    freeObj(oReport)
return

/*/{Protheus.doc} reportDef
Definção do layout do relatório
@type function
@version  1.0
@author Maycon Motta
@since 
@return object, TReport
/*/
static function reportDef()

    local oReport as object
    local oSection as object

    cDefaultFile := "B0828000"

	cHelp := " Controle carregamento exportação"+CRLF
	cHelp += " Para selecionar os filtros desejados, va em 'Outras Ações' e logo em seguida 'Parâmetros'."+CRLF
	cHelp += " Do lado esquerdo, escolha o tipo de relatorio que deseja."

    oReport:= TReport():New(cDefaultFile,"Controle carregamento exportação",{||parametros()}, {|oReport| ReportPrint(oReport)},cHelp) 

    oReport:SetPortrait()
    oReport:SetTotalInLine(.F.)
    oReport:HideParamPage()

	oSection := TRSection():New( oReport, 'Controle carregamento exportação')
    oSection:SetAutoSize( .t.)
	
    TRCell():New( oSection,        'C6_ENTREG' 	    ,cAliasRep, 	'Dt Carregamento'		      ,""                            ,10                                                                   ,.F. ,,"LEFT",.T.,,,,.T.)
	TRCell():New( oSection,        'PLANTA'      	,cAliasRep, 	'Planta'				      ,""                            ,tamSx3("EE8_FABR")[1]+tamSx3("EE8_FALOJA")[1]+tamSx3("A2_NOME")[1]   ,.F. ,,"LEFT",.T.,,,,.T.)
    TRCell():New( oSection,        'TRANSP'         ,cAliasRep, 	'Transportadora'		      ,""                            ,tamSx3("PBK_TRROD")[1]+tamSx3("PBK_NMROD")[1]                        ,.F. ,,"LEFT",.T.,,,,.T.)
    TRCell():New( oSection,        'MODAL'  	    ,cAliasRep, 	'Modal'		                  ,""                            ,13                                                                   ,.F. ,,"LEFT",.T.,,,,.T.)
    TRCell():New( oSection,        'ARMADOR'  	    ,cAliasRep, 	'Armador'		              ,""                            ,tamSx3("PBK_ARMADO")[1]+tamSx3("PBK_NARMAD")[1]                      ,.F. ,,"LEFT",.T.,,,,.T.)
    TRCell():New( oSection,        'DESTINO'     	,cAliasRep, 	'Destino'	                  ,""                            ,tamSx3("EE7_DEST")[1]+tamSx3("YR_CID_DES")[1]                        ,.F. ,,"LEFT",.T.,,,,.T.)
    TRCell():New( oSection,        'PBK_PEDEXP'  	,cAliasRep, 	'Proforma'		              ,PesqPict("PBK","PBK_PEDEXP")  ,tamSx3("PBK_PEDEXP")[1]                                              ,.F. ,,"LEFT",.T.,,,,.T.)
    TRCell():New( oSection,        'CLIENTE'    	,cAliasRep, 	'Cliente'		              ,""                            ,tamSx3("C5_CLIENTE")[1]+tamSx3("C5_LOJACLI")[1]+tamSx3("A1_NOME")[1] ,.F. ,,"LEFT",.T.,,,,.T.)
    TRCell():New( oSection,        'DK0_VIAGID'  	,cAliasRep, 	'Viagem'		              ,PesqPict("DK0","DK0_VIAGID")  ,tamSx3("DK0_VIAGID")[1]                                              ,.F. ,,"LEFT",.T.,,,,.T.)
    TRCell():New( oSection,        'C6_PRODUTO'  	,cAliasRep, 	'Produto'       		      ,PesqPict("SC6","C6_PRODUTO")  ,tamSx3("C6_PRODUTO")[1]                                              ,.F. ,,"LEFT",.T.,,,,.T.)
    TRCell():New( oSection,        'PBK_BOOK'  	    ,cAliasRep, 	'Booking'		              ,PesqPict("PBK","PBK_BOOK")    ,tamSx3("PBK_BOOK")[1]                                                ,.F. ,,"LEFT",.T.,,,,.T.)
    TRCell():New( oSection,        'NAVIO'  	    ,cAliasRep, 	'Navio'		                  ,""                            ,tamSx3("PBK_CDNAV")[1]+tamSx3("PBK_NMNAV")[1]                        ,.F. ,,"LEFT",.T.,,,,.T.)
    TRCell():New( oSection,        'DRAFT'  	    ,cAliasRep, 	'DL Draft'		              ,""                            ,tamSx3("PBK_DTDLDR")[1]+tamSx3("PBK_HRDLDR")[1]                      ,.F. ,,"LEFT",.T.,,,,.T.)
    TRCell():New( oSection,        'CARGA'  	    ,cAliasRep, 	'DL Carga'      		      ,""                            ,tamSx3("PBK_DTDLCR")[1]+tamSx3("PBK_HRDLCR")[1]                      ,.F. ,,"LEFT",.T.,,,,.T.)
    TRCell():New( oSection,        'PBK_ETD'     	,cAliasRep, 	'ETD'		                  ,""                            ,10                                                                   ,.F. ,,"LEFT",.T.,,,,.T.)
    TRCell():New( oSection,        'PBK_ETA'     	,cAliasRep, 	'ETA'	                      ,""                            ,10                                                                   ,.F. ,,"LEFT",.T.,,,,.T.)
    TRCell():New( oSection,        'CHEGADA'     	,cAliasRep, 	'Primeira Pesagem'            ,""                            ,20                                                                   ,.F. ,,"LEFT",.T.,,,,.T.)
    TRCell():New( oSection,        'INICARGA'       ,cAliasRep, 	'Ultima Pesagem    '	      ,""                            ,20                                                                   ,.F. ,,"LEFT",.T.,,,,.T.)
    TRCell():New( oSection,        'FIMCARGA'       ,cAliasRep, 	'Final Carregamento'	      ,""                            ,20                                                                   ,.F. ,,"LEFT",.T.,,,,.T.)
    TRCell():New( oSection,        'EMBARQUE'       ,cAliasRep, 	'Dt.Embarque'	               ,""                            ,20                                                                   ,.F. ,,"LEFT",.T.,,,,.T.)
    TRCell():New( oSection,        'F2_DOC'         ,cAliasRep, 	'Nota Fiscal'   	          ,PesqPict("SF2","F2_DOC")      ,tamSx3("F2_DOC")[1]                                                  ,.F. ,,"LEFT",.T.,,,,.T.)   
    TRCell():New( oSection,        'F2_EMISSAO'     ,cAliasRep, 	'Data Fatur.'       	      ,""                            ,10                                                                   ,.F. ,,"LEFT",.T.,,,,.T.)
    TRCell():New( oSection,        'PCJ_CONTNR'     ,cAliasRep, 	'FCL'   	                  ,PesqPict("PCJ","PCJ_CONTNR")  ,tamSx3("PCJ_CONTNR")[1]                                              ,.F. ,,"LEFT",.T.,,,,.T.)
    TRCell():New( oSection,        'PCJ_LACRE'      ,cAliasRep, 	'Lacre Armador'   	          ,PesqPict("PCJ","PCJ_LACRE")   ,tamSx3("PCJ_LACRE")[1]                                               ,.F. ,,"LEFT",.T.,,,,.T.)
    TRCell():New( oSection,        'PCJ_TARA'       ,cAliasRep, 	'Tara'      	              ,PesqPict("PCJ","PCJ_TARA")    ,tamSx3("PCJ_TARA")[1]                                                ,.F. ,,"RIGHT",.T.,,,,.T.)
    TRCell():New( oSection,        'EE8_PSBRTO'     ,cAliasRep, 	'Peso Bruto'      	          ,PesqPict("EE8","EE8_PSBRTO")  ,tamSx3("EE8_PSBRTO")[1]                                              ,.F. ,,"RIGHT",.T.,,,,.T.)
    TRCell():New( oSection,        'VGM'            ,cAliasRep, 	'VGM'      	                  ,PesqPict("EE8","EE8_PSBRTO")  ,tamSx3("EE8_PSBRTO")[1]                                              ,.F. ,,"RIGHT",.T.,,,,.T.)
    TRCell():New( oSection,        'EE8_PRCTOT'     ,cAliasRep, 	'Valor Proforma'   	          ,PesqPict("EE8","EE8_PRCTOT")  ,tamSx3("EE8_PRCTOT")[1]                                              ,.F. ,,"RIGHT",.T.,,,,.T.)
    TRCell():New( oSection,        'F2_VALBRUT'     ,cAliasRep, 	'Valor Nota Fiscal'   	      ,PesqPict("SF2","F2_VALBRUT")  ,tamSx3("F2_VALBRUT")[1]                                              ,.F. ,,"RIGHT",.T.,,,,.T.)

return oReport


/*/{Protheus.doc} reportPrint
Realiza a impressão do relatório.
@type function
@version  1.0
@author Maycon Motta
@since 
@param oReport, object, TReport
/*/
static function reportPrint(oReport)    

    local nRegs as numeric
    local oSection as object
    local cWhereMod as character
    Local dDataEmba := ''


    IF cModal == "R"
        cWhereMod := "% "+ "(PBK.PBK_TRROD >= '"+cCodTraIni+"' AND PBK.PBK_TRROD <= '"+cCodTraFim+"' AND PBK.PBK_TRROD <> '')" + "%"
    endif
    if cModal == "F"
        cWhereMod := "% "+  "(PBK.PBK_TRFER >= '"+cCodTraIni+"' AND PBK.PBK_TRFER <= '"+cCodTraFim+"' AND PBK.PBK_TRFER <> '')"+" %"
    endif
   if cModal == "T"
        cWhereMod :="% "+  " EE7.D_E_L_E_T_ = ' ' "+" %"
   endif

   oSection  := oReport:Section(1)


    beginSql alias cAliasRep
        SELECT DISTINCT SC6.C6_ENTREG, 
                        EE8.EE8_FABR,
                        EE8.EE8_FALOJA, 
                        SA2.A2_NOME, 
                        PBK.PBK_TRROD, 
                        SY5ROD.Y5_NOME AS PBK_NMROD,
                        PBK.PBK_TRFER, 
                        SY5FER.Y5_NOME AS PBK_NMFER,
                        PBK.PBK_ARMADO, 
                        SY5ARM.Y5_NOME AS PBK_NARMAD,
                        EE7.EE7_DEST,
                        SYR.YR_CID_DES,
                        PBK.PBK_PEDEXP, 
                        SC5.C5_CLIENTE, 
                        SC5.C5_LOJACLI, 
                        SA1.A1_NOME,
                        DK0.DK0_VIAGID, 
                        SC6.C6_PRODUTO,
                        PBK.PBK_BOOK,
                        PBK.PBK_CDNAV, 
                        EE6.EE6_NOME AS PBK_NMNAV,
                        PBK.PBK_DTDLDR, 
                        PBK.PBK_HRDLDR,
                        PBK.PBK_DTDLCR,
                        PBK.PBK_HRDLCR,
                        PBK.PBK_ETD,
                        PBK.PBK_ETA,
                        PC2.PC2_DTPS1,
                        PC2.PC2_HRPS1,
                        PC2.PC2_DTPS2,
                        PC2.PC2_HRPS2,
                        SF2.F2_DOC,
                        SF2.F2_EMISSAO,
                        PCJ.PCJ_CONTNR,
                        PCJ.PCJ_LACRE,PCJ.PCJ_LCSIF,
                        PCJ.PCJ_TARA,
                        EE8.EE8_PSBRTO,
                        EE8.EE8_PRCTOT,
                        SF2.F2_VALBRUT,
                        SA2.A2_COD,
                        SA2.A2_NOME,
                        PBK_ARMAD1,
                        PCJ_PREEMB
                
        FROM %table:PBK% PBK 
        LEFT JOIN %table:SY5% SY5ROD ON (SY5ROD.Y5_COD    = PBK.PBK_TRROD AND
                                         SY5ROD.%notDel%)
        LEFT JOIN %table:SY5% SY5FER ON (SY5FER.Y5_COD    = PBK.PBK_TRFER AND
                                         SY5FER.%notDel%)
        LEFT JOIN %table:SY5% SY5ARM ON (SY5ARM.Y5_COD    = PBK.PBK_ARMADO AND
                                         SY5ARM.%notDel%)
        LEFT JOIN %table:EE6% EE6 ON (EE6_COD = PBK.PBK_CDNAV AND
                                      EE6.%notDel%)
        INNER JOIN %table:SC5% SC5 ON (SC5.C5_FILIAL = PBK.PBK_FILIAL AND 
                                       SC5.C5_NUM    = PBK.PBK_PEDVND AND
                                       SC5.%notDel%)
        INNER JOIN %table:SC6% SC6 ON (SC6.C6_FILIAL = SC5.C5_FILIAL  AND
                                       SC6.C6_NUM    = SC5.C5_NUM     AND
                                       SC6.%notDel%)
        INNER JOIN %table:SA1% SA1 ON  (SA1.A1_COD  = SC5.C5_CLIENTE AND
                                        SA1.A1_LOJA = SC5.C5_LOJACLI    AND
                                        SA1.%notDel%)
        INNER JOIN %table:SF2% SF2 ON  (SF2.F2_FILIAL = SC5.C5_FILIAL AND
                                        SF2.F2_DOC    = SC5.C5_NOTA   AND
                                        SF2.F2_SERIE  = SC5.C5_SERIE  AND
                                        SF2.%notDel%)
        LEFT JOIN %table:DK0% DK0 ON ( SUBSTR(DK0_TRANSP,1,6) = SF2.F2_TRANSP AND
                                       DK0.DK0_CARGA  = SF2.F2_CARGA          AND
                                       DK0.%notDel%)
        LEFT JOIN %table:PC2% PC2 ON ( PC2.PC2_VIAGEM   = DK0.DK0_VIAGID AND
                                       PC2.%notDel%)
        INNER JOIN %table:EE7% EE7 ON( EE7.EE7_FILIAL = PBK.PBK_FILIAL AND
                                       EE7.EE7_PEDIDO = PBK.PBK_PEDEXP AND
                                       EE7.%notDel%)
        INNER JOIN %table:EE8% EE8 ON (EE8.EE8_FILIAL = EE7.EE7_FILIAL AND
                                       EE8.EE8_PEDIDO = EE7.EE7_PEDIDO AND
                                       EE8.%notDel%)
        INNER JOIN %table:SA2% SA2 ON  (SA2.A2_COD  = EE8.EE8_FABR     AND
                                        SA2.A2_LOJA = EE8.EE8_FALOJA   AND
                                        SA2.%notDel%)
        LEFT JOIN %table:SYR% SYR  ON(SYR.YR_VIA      = EE7.EE7_VIA    AND
                                      SYR.YR_DESTINO  = EE7.EE7_DEST   AND
                                      SYR.YR_ORIGEM   = EE7.EE7_ORIGEM AND
                                      SYR.%notDel%)                               
        LEFT JOIN %table:PCJ% PCJ ON (PCJ.PCJ_FILIAL = EE7.EE7_FILIAL AND
                                       PCJ.PCJ_PEDIDO = EE7.EE7_PEDIDO AND
                                       PCJ.%notDel%)
        WHERE  SC6.C6_ENTREG  >= %exp:dtos(dDtCargIni)% AND
               SC6.C6_ENTREG  <= %exp:dtos(dDtCargFim)% AND
               SC6.C6_PRODUTO >= %exp:cCodPrdIni% AND
               SC6.C6_PRODUTO <= %exp:cCodPrdFim% AND
               PBK.PBK_ARMADO >= %exp:cCodArmIni% AND
               PBK.PBK_ARMADO <= %exp:cCodArmFim% AND
               PBK.PBK_CDNAV  >= %exp:cCodNavIni% AND
               PBK.PBK_CDNAV  <= %exp:cCodNavFim% AND
               EE8.EE8_FABR   >= %exp:cCodEmbIni% AND
               EE8.EE8_FALOJA >= %exp:cLojEmbIni% AND
               EE8.EE8_FABR   <= %exp:cCodEmbFim% AND
               EE8.EE8_FALOJA <= %exp:cLojEmbFim% AND
               EE7.EE7_DEST   >= %exp:cCodDstIni% AND
               EE7.EE7_DEST   <= %exp:cCodDstFim% AND
               %exp:cWhereMod% AND
               PBK.%notDel%
    endSql

    nRegs     := contar(cAliasRep, "!eof()")
    
    (cAliasRep)->(dbGoTop())

    oReport:setMeter(nRegs)
    oSection:Init()

    while (cAliasRep)->(!eof())

        //PEGANDO O ARMADOR
        cQuery		:= " SELECT Y5_FORNECE, Y5_NOME "
        cQuery		+= " FROM " + RetSqlName("SY5") + " "
        cQuery		+= " WHERE Y5_FORNECE = '"+ (cAliasRep)->PBK_ARMAD1 +"' "
        cQuery := ChangeQuery(cQuery)
        cAliasTRB	:= MPSysOpenQuery(cQuery)
    
        If !(cAliasTRB)->(EOF())
            cArmador := (cAliasTRB)->Y5_FORNECE
            nCodArmador := (cAliasTRB)->Y5_NOME
        EndIf

        //PEGANDO A DATA DE EMBARQUE
        cQuery1		:= " SELECT EEC_DTEMBA "
        cQuery1		+= " FROM " + RetSqlName("EEC") + " "
        cQuery1		+= " WHERE EEC_PEDREF = '"+ (cAliasRep)->PCJ_PREEMB +"' "
        cQuery1 := ChangeQuery(cQuery1)
        cAliasEEC	:= MPSysOpenQuery(cQuery1)
    
        If !(cAliasEEC)->(EOF())
            dDataEmba := (cAliasEEC)->EEC_DTEMBA
        EndIf


        oReport:IncMeter()
        oSection:Cell('C6_ENTREG' ):setValue( (cAliasRep)->(dToc(stod(C6_ENTREG))) )
        oSection:Cell('PLANTA'    ):setValue((cAliasRep)->(EE8_FABR+"-"+EE8_FALOJA+" / "+A2_NOME))
        oSection:Cell('TRANSP'    ):setValue(iif (!empty((cAliasRep)->PBK_TRROD),(cAliasRep)->(PBK_TRROD+"-"+PBK_NMROD) ,(cAliasRep)->(PBK_TRFER+"-"+PBK_NMFER))) 
        oSection:Cell('MODAL'  	  ):setValue(iif(cModal == "R", "Rodoviário",Iif(cModal =="F", "Ferroviário","Todos")))
        oSection:Cell('ARMADOR'   ):setValue((cAliasTRB)->(Y5_FORNECE + "-"+Y5_NOME))
        oSection:Cell('DESTINO'   ):setValue((cAliasRep)->(EE7_DEST+"/"+YR_CID_DES))
        oSection:Cell('PBK_PEDEXP'):setValue((cAliasRep)->PBK_PEDEXP)
        oSection:Cell('CLIENTE'   ):setValue((cAliasRep)->(C5_CLIENTE+"-"+C5_LOJACLI+"/"+A1_NOME))
        oSection:Cell('DK0_VIAGID'):setValue((cAliasRep)->DK0_VIAGID)
        oSection:Cell('C6_PRODUTO'):setValue((cAliasRep)->C6_PRODUTO)
        oSection:Cell('PBK_BOOK'  ):setValue((cAliasRep)->PBK_BOOK)
        oSection:Cell('NAVIO'  	  ):setValue((cAliasRep)->(Alltrim(PBK_CDNAV)+"-"+PBK_NMNAV))
        oSection:Cell('DRAFT'  	  ):setValue((cAliasRep)->(dtoc(stod(PBK_DTDLDR))+" "+PBK_HRDLDR))
        oSection:Cell('CARGA'  	  ):setValue((cAliasRep)->(dtoc(sTod(PBK_DTDLCR))+" "+PBK_HRDLCR))
        oSection:Cell('PBK_ETD'   ):setValue((cAliasRep)->(dtoc(sTod(PBK_ETD))))
        oSection:Cell('PBK_ETA'   ):setValue((cAliasRep)->(dtoc(stod(PBK_ETA))))
        oSection:Cell('CHEGADA'   ):setValue((cAliasRep)->(dtoc(stod(PC2_DTPS1))+" "+PC2_HRPS1))
        oSection:Cell('INICARGA'  ):setValue((cAliasRep)->(dtoc(stod(PC2_DTPS2))+" "+PC2_HRPS2))
        oSection:Cell('FIMCARGA'  ):setValue("")
        oSection:Cell('EMBARQUE'  ):setValue((cAliasEEC)->(dtoc(stod(dDataEmba))))
        oSection:Cell('F2_DOC'    ):setValue((cAliasRep)->F2_DOC)
        oSection:Cell('F2_EMISSAO'):setValue((cAliasRep)->(dToc(stod(F2_EMISSAO))))
        oSection:Cell('PCJ_CONTNR'):setValue((cAliasRep)->PCJ_CONTNR)
        oSection:Cell('PCJ_LACRE' ):setValue((cAliasRep)->PCJ_LACRE)
        oSection:Cell('PCJ_TARA'  ):setValue((cAliasRep)->PCJ_TARA)
        oSection:Cell('EE8_PSBRTO'):setValue((cAliasRep)->EE8_PSBRTO)
        oSection:Cell('VGM'       ):setValue((cAliasRep)->(PCJ_TARA+EE8_PSBRTO))
        oSection:Cell('EE8_PRCTOT'):setValue((cAliasRep)->EE8_PRCTOT)
        oSection:Cell('F2_VALBRUT'):setValue((cAliasRep)->F2_VALBRUT)
        oSection:PrintLine()
        
        (cAliasEEC)->(DbCloseArea())
        (cAliasTRB)->(DbCloseArea())
        (cAliasRep)->(dbSkip())
    enddo
    oSection:Finish()
return

/*/{Protheus.doc} parametros
Função para informar os parâmetros do relatório.
@type function
@version  1.0
@author Maycon Motta
@since 
@return logical, confirmado ?
/*/
static function parametros()

    local aParamBox as array
    local aRetPar   as array
    local aModal  as array
    local lRetPar   as logical

    aModal  := {"F=Ferroviário","R=Rodoviário","T=Todos os modais"}
    aParamBox := {}
    aRetPar   := {}

    //-------------------------------------------------------------------------
    //Definção dos parâmetros do parambox
    //------------------------------------------------------------------------
    aAdd(aParamBox,{9,"Informe os parâmetros do relatório:" ,150,7,.T.})
    aAdd(aParamBox,{1,"Data carregamento de" ,stod(""),"","","","",50,.F.}) 
    aAdd(aParamBox,{1,"Data carregamento até",stod(""),"","","","",50,.T.}) 
    
    aAdd(aParamBox,{1,"Cod.embarque de" ,space(tamSx3("EE8_FABR")[1]),"","","AVE014","",50,.F.}) 
    aAdd(aParamBox,{1,"Loja embarque de",space(tamSx3("EE8_FALOJA")[1]),"","","","",50,.F.}) 
    
    aAdd(aParamBox,{1,"Cod.embarque ate" ,space(tamSx3("EE8_FABR")[1]),"","","AVE014","",50,.T.}) 
    aAdd(aParamBox,{1,"Loja embarque ate",space(tamSx3("EE8_FALOJA")[1]),"","","","",50,.T.}) 
    
    aAdd(aParamBox,{1,"Cod.transp de" ,space(tamSx3("PBK_TRROD")[1]),"","","SY5","",50,.F.}) 
    aAdd(aParamBox,{1,"Cod.transp ate",space(tamSx3("PBK_TRROD")[1]),"","","SY5","",50,.T.}) 
    
    aAdd(aParamBox,{1,"Armador de" ,space(tamSx3("PBK_ARMADO")[1]),"","","SY5","",50,.F.}) 
    aAdd(aParamBox,{1,"Armador ate",space(tamSx3("PBK_ARMADO")[1]),"","","SY5","",50,.T.}) 
    
    aAdd(aParamBox,{1,"Destino de" ,space(tamSx3("EE7_DEST")[1]),"","","","",50,.F.}) 
    aAdd(aParamBox,{1,"Destino ate",space(tamSx3("EE7_DEST")[1]),"","","","",50,.T.}) 
    
    aAdd(aParamBox,{1,"Produto de" ,space(tamSx3("C6_PRODUTO")[1]),"","","SB1","",50,.F.}) 
    aAdd(aParamBox,{1,"Produto ate",space(tamSx3("C6_PRODUTO")[1]),"","","SB1","",50,.T.}) 
    
    aAdd(aParamBox,{1,"Navio de" ,space(tamSx3("PBK_CDNAV")[1]),"","","EE6","",50,.F.}) 
    aAdd(aParamBox,{1,"Navio ate",space(tamSx3("PBK_CDNAV")[1]),"","","EE6","",50,.T.}) 
    
    aAdd(aParamBox,{2,"Modal",1,aModal,70,"",.T.})

    If (lRetPar:=ParamBox(aParamBox,"Parâmetros",@aRetPar,,,,,,,"B0828000",.T., .T.))
        
        
        dDtCargIni := aRetPar[2]
        dDtCargFim := aRetPar[3]
        cCodEmbIni := aRetPar[4]  
        cLojEmbIni := aRetPar[5]  
        cCodEmbFim := aRetPar[6]
        cLojEmbFim := aRetPar[7]  
        cCodTraIni := aRetPar[8]  
        cCodTraFim := aRetPar[9]  
        cCodArmIni := aRetPar[10]  
        cCodArmFim := aRetPar[11]  
        cCodDstIni := aRetPar[12]  
        cCodDstFim := aRetPar[13]  
        cCodPrdIni := aRetPar[14]  
        cCodPrdFim := aRetPar[15]  
        cCodNavIni := aRetPar[16]  
        cCodNavFim := aRetPar[17]  
        if valType(aRetPar[18]) == 'N'
            cModal := substr(aModal[aRetPar[18]],1,1)
        else
            cModal := substr(aRetPar[18],1,1)
        endif
    endif

    aSize(aParamBox,0)
    aSize(aRetPar,0)
    aSize(aModal,0)
    
return lRetPar


Static Function VersaoGT()
    Local cTexto := ""
    Local oDlg, oSay
    Local oFont:= TFont():New("Courier New",,-14,.T.)
    
    DEFINE MSDIALOG oDlg FROM 0,0 TO 400,400 TITLE "Controle de Versão" PIXEL
    
    cTexto := "VERSÃO  AUTOR              CHAMADO    DATA   " + CHR(10) 
    cTexto += "======  =================  =======  ======== " + CHR(10)
    cTexto += "001.0   MAYCON MOTTA       111663   23/09/22 " + CHR(10) // RELATÓRIO DE CARREGAMENTO
    @ 10,70 SAY oSay PROMPT "b0828000" SIZE 330,10 COLORS CLR_HBLUE FONT oFont OF oDlg PIXEL
    @ 20,10 SAY oSay PROMPT cTexto SIZE 580,390 FONT oFont OF oDlg PIXEL
        
    ACTIVATE MSDIALOG oDlg CENTERED
Return .T.




