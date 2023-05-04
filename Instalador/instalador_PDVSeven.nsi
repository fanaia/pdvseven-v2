; Script generated by the HM NIS Edit Script Wizard.

; HM NIS Edit Wizard helper defines
!define PRODUCT_NAME "PDVSeven"
!define PRODUCT_VERSION "2.24.6.1"
!define PRODUCT_PUBLISHER "PDVSeven Automa��o Comercial"
!define PRODUCT_WEB_SITE "http://www.pdvseven.com.br"
!define PRODUCT_DIR_REGKEY "Software\PDV7\${PRODUCT_NAME}"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "instalador_${PRODUCT_NAME}-${PRODUCT_VERSION}.exe"
LoadLanguageFile "${NSISDIR}\Contrib\Language files\PortugueseBR.nlf"
InstallDir "C:\PDV7"
Icon "PDV7.ico"
UninstallIcon "${NSISDIR}\Contrib\Graphics\Icons\modern-uninstall.ico"
InstallDirRegKey HKLM "${PRODUCT_DIR_REGKEY}" ""
ComponentText "Marque os componentes que queira instalar:"
SetCompressor /SOLID lzma

ShowInstDetails show
ShowUnInstDetails show

SectionGroup /e "Programas (auto update)"

	Section
		ExecWait "netsh advfirewall firewall delete rule name=PDVSevenTCP"
		ExecWait "netsh advfirewall firewall delete rule name=PDVSevenUDP"
		SetOutPath "$INSTDIR"
		SetOverwrite on
		File PDV7.ico
		File /r /x *vshost*.* /x *.UI.* "..\bin\*"
		CreateDirectory "$SMPROGRAMS\PDVSeven"
		ExecWait "netsh advfirewall firewall add rule name=PDVSevenTCP dir=in action=allow protocol=TCP localport=80,1433,7777,8888,9999,9000,15000"
		ExecWait "netsh advfirewall firewall add rule name=PDVSevenUDP dir=in action=allow protocol=UDP localport=80,1433,15000,7777,8888"
	SectionEnd

	Section /o "Caixa"  SEC1A
		SetOutPath "$INSTDIR"
		SetOverwrite on
		File /r /x *vshost*.* "..\bin\a7D.PDV.Caixa.UI.*"
		File /r /x *vshost*.* "..\bin\a7D.PDV.Terminal.UI.*"
		File /r /x *vshost*.* "..\bin\a7D.PDV.LocalizadorBalanca.UI.*"
		SetOverwrite off
		File "..\bin\a7D.PDV.Caixa.UI.exe.config"
		CreateShortCut "$SMPROGRAMS\PDVSeven\Caixa.lnk" "$INSTDIR\a7D.PDV.Caixa.UI.exe"
		CreateShortCut "$DESKTOP\Caixa.lnk" "$INSTDIR\a7D.PDV.Caixa.UI.exe"
	SectionEnd

	Section /o "BackOffice" SEC1B
		SetOutPath "$INSTDIR"
		SetOverwrite on
		File /r /x *vshost*.* "..\bin\a7D.PDV.BackOffice.UI.*"
		File /r /x *vshost*.* "..\bin\a7D.PDV.LocalizadorBalanca.UI.*"
		SetOverwrite off
		File "..\bin\a7D.PDV.BackOffice.UI.exe.config"
		CreateShortCut "$SMPROGRAMS\PDVSeven\BackOffice.lnk" "$INSTDIR\a7D.PDV.BackOffice.UI.exe"
		CreateShortCut "$DESKTOP\BackOffice.lnk" "$INSTDIR\a7D.PDV.BackOffice.UI.exe"
	SectionEnd

	Section /o "Terminal Windows" SEC1C
		SetOutPath "$INSTDIR"
		SetOverwrite on
		File /r /x *vshost*.* "..\bin\a7D.PDV.Terminal.UI.*"
		File /r /x *vshost*.* "..\bin\a7D.PDV.LocalizadorBalanca.UI.*"
		SetOverwrite off
		File "..\bin\a7D.PDV.Terminal.UI.exe.config"
		CreateShortCut "$SMPROGRAMS\PDVSeven\Terminal.lnk" "$INSTDIR\a7D.PDV.Terminal.UI.exe"
		CreateShortCut "$DESKTOP\Terminal.lnk" "$INSTDIR\a7D.PDV.Terminal.UI.exe"
	SectionEnd

SectionGroupEnd

SectionGroup /e "Servidor"

	Section /o "Integrador + WS2 + EXE" SEC2A
		SetOutPath "$INSTDIR"
		SetOverwrite on
		File /r /x *vshost*.* "..\bin\*.UI.*"

		SetOutPath "$INSTDIR\WebServices\www2"
		File /r /x *vshost*.* "..\Publish\www2\*"

		SetOutPath "$INSTDIR\WebServices\www2\Release"
		File /r "..\Publish\Mobile\*"

		CreateShortCut "$SMPROGRAMS\PDVSeven\Integra��o.lnk" "$INSTDIR\a7D.PDV.Integracao.Servico.UI.exe"
		CreateShortCut "$DESKTOP\Integra��o.lnk" "$INSTDIR\a7D.PDV.Integracao.Servico.UI.exe"

		WriteRegStr "HKLM" "SOFTWARE\Microsoft\Windows\CurrentVersion\Run" "PDV7" "$INSTDIR\a7D.PDV.Integracao.Servico.UI.exe"
	SectionEnd

	Section /o "API SAT (antiga)" SEC2B
		SetOutPath "$INSTDIR\WebServices\www_SAT"
		SetOverwrite on
		File /r /x *vshost*.* "..\Publish\www_SAT\*"
	SectionEnd

	Section /o "API FISCAL (nova)" SEC2C
		SetOutPath "$INSTDIR\WebServices\www_Fiscal"
		SetOverwrite on
		File /r /x *vshost*.* "..\Publish\www_Fiscal\*"
	SectionEnd

;	Section /o "Instalar Instalar SQL 2008 Express" SEC2D
;		SetOutPath "$INSTDIR\Temp"
;		SetOverwrite on
;		File "instalar_SQL.bat"
;		ExecWait "$INSTDIR\Temp\instalar_SQL.bat"
;	SectionEnd

SectionGroupEnd

SectionGroup /e "Opcionais"

	Section /o "Autoatendimento" SEC3A
		SetOutPath "$INSTDIR\AutoAtendimento"
		SetOverwrite on
		File /r /x *vshost*.* "..\Publish\AutoAtendimento\*"
		SetOverwrite off
		File "..\Publish\AutoAtendimento\*.config"
		CreateShortCut "$SMPROGRAMS\PDVSeven\Autoatendimento.lnk" "$INSTDIR\AutoAtendimento\a7D.PDV.AutoAtendimento.UI.exe"
		CreateShortCut "$DESKTOP\Autoatendimento.lnk" "$INSTDIR\AutoAtendimento\a7D.PDV.AutoAtendimento.UI.exe"
	SectionEnd

	Section /o "Painel Mesa Comanda" SEC3B
		SetOutPath "$INSTDIR\PainelMesaComanda"
		SetOverwrite on
		File /r /x *vshost*.* "..\Publish\PainelMesaComanda\*"
		SetOverwrite off
		File "..\Publish\PainelMesaComanda\*.config"
		CreateShortCut "$SMPROGRAMS\PDVSeven\Painel Mesa Comanda.lnk" "$INSTDIR\PainelMesaComanda\a7D.PDV.PainelMesaComanda.UI.exe"
		CreateShortCut "$DESKTOP\Painel Mesa Comanda.lnk" "$INSTDIR\PainelMesaComanda\a7D.PDV.PainelMesaComanda.UI.exe"
	SectionEnd

	Section /o "Controle de Sa�da" SEC3C
		SetOutPath "$INSTDIR\SaidaComanda"
		SetOverwrite on
		File /r /x *vshost*.* "..\Publish\SaidaComanda\*"
		SetOverwrite off
		File "..\Publish\SaidaComanda\*.config"
		CreateShortCut "$SMPROGRAMS\PDVSeven\Saida Comanda.lnk" "$INSTDIR\SaidaComanda\a7D.PDV.SaidaComanda.UI.exe"
		CreateShortCut "$DESKTOP\Saida Comanda.lnk" "$INSTDIR\SaidaComanda\a7D.PDV.SaidaComanda.UI.exe"
	SectionEnd

SectionGroupEnd

Section -AdditionalIcons
  WriteIniStr "$INSTDIR\${PRODUCT_NAME}.url" "InternetShortcut" "URL" "${PRODUCT_WEB_SITE}"
  CreateShortCut "$SMPROGRAMS\PDVSeven\Website.lnk" "$INSTDIR\${PRODUCT_NAME}.url"
  CreateShortCut "$SMPROGRAMS\PDVSeven\Uninstall.lnk" "$INSTDIR\uninst.exe"
SectionEnd

Section -Post
  WriteUninstaller "$INSTDIR\uninst.exe"
  WriteRegStr HKLM "${PRODUCT_DIR_REGKEY}" "" "$INSTDIR\a7D.PDV.BackOffice.UI.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayIcon" "$INSTDIR\PDV7.ico"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "URLInfoAbout" "${PRODUCT_WEB_SITE}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
SectionEnd


Function un.onUninstSuccess
  HideWindow
  MessageBox MB_ICONINFORMATION|MB_OK "$(^Name) foi removido com sucesso do seu computador."
FunctionEnd

Function un.onInit
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "Tem certeza que quer remover completamente $(^Name) e todos os seus componentes?" IDYES +2
  Abort
FunctionEnd

Section Uninstall

  RMDir /R "$SMPROGRAMS\PDVSeven"
  RMDir /R "C:\PDV7"

  Delete "$DESKTOP\Caixa.lnk"
  Delete "$DESKTOP\Terminal.lnk"
  Delete "$DESKTOP\BackOffice.lnk"
  Delete "$DESKTOP\Configurador.lnk"
  Delete "$DESKTOP\Integra��o.lnk"
  Delete "$DESKTOP\Painel Mesa Comanda.lnk"
  Delete "$DESKTOP\Autoatendimento.lnk"
  Delete "$DESKTOP\Saida Comanda.lnk"

  ExecWait "netsh advfirewall firewall delete rule name=PDVSevenTCP"
  ExecWait "netsh advfirewall firewall delete rule name=PDVSevenUDP"

  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  DeleteRegKey HKLM "${PRODUCT_DIR_REGKEY}"
  
  SetAutoClose true

SectionEnd