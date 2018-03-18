{ ****************************************************************************** }
{ Projeto: Componentes TBGConnection }
{ Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil }
{ }
{ Direitos Autorais Reservados (c) 2009   Isaque Pinheiro }
{ }
{ Colaboradores nesse arquivo: }
{ }
{ Você pode obter a última versão desse arquivo na pagina do  Projeto TBGConnection }
{ Componentes localizado em      https://github.com/bittencourtthulio/TBGConnection }
{ }
{ Esta biblioteca é software livre; você pode redistribuí-la e/ou modificá-la }
{ sob os termos da Licença Pública Geral Menor do GNU conforme publicada pela }
{ Free Software Foundation; tanto a versão 2.1 da Licença, ou (a seu critério) }
{ qualquer versão posterior. }
{ }
{ Esta biblioteca é distribuída na expectativa de que seja útil, porém, SEM }
{ NENHUMA GARANTIA; nem mesmo a garantia implícita de COMERCIABILIDADE OU }
{ ADEQUAÇÃO A UMA FINALIDADE ESPECÍFICA. Consulte a Licença Pública Geral Menor }
{ do GNU para mais detalhes. (Arquivo LICENÇA.TXT ou LICENSE.TXT) }
{ }
{ Você deve ter recebido uma cópia da Licença Pública Geral Menor do GNU junto }
{ com esta biblioteca; se não, escreva para a Free Software Foundation, Inc., }
{ no endereço 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA. }
{ Você também pode obter uma copia da licença em: }
{ http://www.opensource.org/licenses/lgpl-license.php }
{ }
{ Daniel Simões de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br }
{ Praça Anita Costa, 34 - Tatuí - SP - 18270-410 }
{ }
{ ****************************************************************************** }

{ ******************************************************************************
  |* Historico
  |*
  |* 29/03/2012: Isaque Pinheiro / Régys Borges da Silveira
  |*  - Criação e distribuição da Primeira Versao
  ******************************************************************************* }
UNIT uPrincipal;

INTERFACE

USES
  JclIDEUtils,
  JclCompilerUtils,
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  ComCtrls,
  StdCtrls,
  ExtCtrls,
  Buttons,
  Pngimage,
  ShlObj,
  UFrameLista,
  IOUtils,
  Types,
  JvComponentBase,
  JvCreateProcess,
  JvExControls,
  JvAnimatedImage,
  JvGIFCtrl,
  JvWizard,
  JvWizardRouteMapNodes,
  CheckLst, Vcl.Imaging.jpeg, dxGDIPlusClasses;

TYPE
  TDestino = (TdSystem, TdDelphi, TdNone);

  TfrmPrincipal = CLASS(TForm)
    WizPrincipal: TJvWizard;
    WizMapa: TJvWizardRouteMapNodes;
    WizPgConfiguracao: TJvWizardInteriorPage;
    WizPgObterFontes: TJvWizardInteriorPage;
    WizPgInstalacao: TJvWizardInteriorPage;
    WizPgFinalizar: TJvWizardInteriorPage;
    WizPgInicio: TJvWizardWelcomePage;
    Label4: TLabel;
    Label5: TLabel;
    EdtDelphiVersion: TComboBox;
    EdtPlatform: TComboBox;
    Label2: TLabel;
    EdtDirDestino: TEdit;
    Label1: TLabel;
    EdtURL: TEdit;
    LblInfoObterFontes: TLabel;
    LstMsgInstalacao: TListBox;
    PnlTopo: TPanel;
    Label9: TLabel;
    BtnSelecDirInstall: TSpeedButton;
    PgbInstalacao: TProgressBar;
    Label10: TLabel;
    BtnSVNCheckoutUpdate: TSpeedButton;
    btnInstalarTBG: TSpeedButton;
    CkbFecharTortoise: TCheckBox;
    BtnVisualizarLogCompilacao: TSpeedButton;
    PnlInfoCompilador: TPanel;
    WizPgPacotes: TJvWizardInteriorPage;
    FrameDpk: TframePacotes;
    LbInfo: TListBox;
    BtnWCInfo: TButton;
    JvCreateProcess1: TJvCreateProcess;
    ClbDelphiVersion: TCheckListBox;
    Label23: TLabel;
    Label27: TLabel;
    Label26: TLabel;
    ImgLogomarca: TImage;
    Label6: TLabel;
    Label20: TLabel;
    Label28: TLabel;
    Label19: TLabel;
    lblUrlTBG: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label12: TLabel;
    Label11: TLabel;
    ChkDeixarSomenteLIB: TCheckBox;
    CkbRemoverArquivosAntigos: TCheckBox;
    Label3: TLabel;
    Label18: TLabel;
    Label14: TLabel;
    Image1: TImage;
    PROCEDURE FormCreate(Sender: TObject);
    PROCEDURE FormClose(Sender: TObject; VAR Action: TCloseAction);
    PROCEDURE EdtDelphiVersionChange(Sender: TObject);
    PROCEDURE WizPgInicioNextButtonClick(Sender: TObject; VAR Stop: Boolean);
    PROCEDURE URLClick(Sender: TObject);
    PROCEDURE BtnSelecDirInstallClick(Sender: TObject);
    PROCEDURE WizPrincipalCancelButtonClick(Sender: TObject);
    PROCEDURE WizPrincipalFinishButtonClick(Sender: TObject);
    PROCEDURE WizPgConfiguracaoNextButtonClick(Sender: TObject; VAR Stop: Boolean);
    PROCEDURE BtnSVNCheckoutUpdateClick(Sender: TObject);
    PROCEDURE WizPgObterFontesEnterPage(Sender: TObject; CONST FromPage: TJvWizardCustomPage);
    PROCEDURE btnInstalarTBGClick(Sender: TObject);
    PROCEDURE WizPgObterFontesNextButtonClick(Sender: TObject; VAR Stop: Boolean);
    PROCEDURE WizPgInstalacaoNextButtonClick(Sender: TObject; VAR Stop: Boolean);
    PROCEDURE BtnVisualizarLogCompilacaoClick(Sender: TObject);
    PROCEDURE WizPgInstalacaoEnterPage(Sender: TObject; CONST FromPage: TJvWizardCustomPage);
    PROCEDURE BtnWCInfoClick(Sender: TObject);
    PROCEDURE ClbDelphiVersionClick(Sender: TObject);
    PROCEDURE WriteToTXT(CONST ArqTXT: STRING; ABinaryString: AnsiString; CONST AppendIfExists: Boolean = True; CONST AddLineBreak: Boolean = True);
    procedure JvCreateProcess1ErrorRawRead(Sender: TObject; const S: string);
    procedure imgLogomarcaClick(Sender: TObject);
  PRIVATE
    FCountErros: Integer;
    OTBG: TJclBorRADToolInstallations;
    IVersion: Integer;
    TPlatform: TJclBDSPlatform;
    SDirRoot: STRING;
    SDirLibrary: STRING;
    SDirPackage: STRING;
    PastaTBG: STRING;
    SDestino: TDestino;
    SPathBin: STRING;
    PROCEDURE BeforeExecute(Sender: TJclBorlandCommandLineTool);
    PROCEDURE AddLibrarySearchPath;
    PROCEDURE OutputCallLine(CONST Text: STRING);
    PROCEDURE SetPlatformSelected;
    FUNCTION IsCheckOutJaFeito(CONST ADiretorio: STRING): Boolean;
    PROCEDURE CreateDirectoryLibrarysNotExist;
    PROCEDURE GravarConfiguracoes;
    PROCEDURE LerConfiguracoes;
    FUNCTION PathApp: STRING;
    FUNCTION PathArquivoIni: STRING;
    FUNCTION PathArquivoLog: STRING;
    FUNCTION PathSystem: STRING;
    FUNCTION RegistrarActiveXServer(CONST AServerLocation: STRING; CONST ARegister: Boolean): Boolean;
    PROCEDURE CopiarArquivoTo(ADestino: TDestino; CONST ANomeArquivo: STRING);
    PROCEDURE ExtrairDiretorioPacote(NomePacote: STRING);
    PROCEDURE AddLibraryPathToDelphiPath(CONST APath, AProcurarRemover: STRING);
    PROCEDURE FindDirs(ADirRoot: STRING; BAdicionar: Boolean = True);
    PROCEDURE DeixarSomenteLib;
    PROCEDURE RemoverArquivosAntigosDoDisco;
    PROCEDURE RemoverDiretoriosEPacotesAntigos;
    FUNCTION RunAsAdminAndWaitForCompletion(HWnd: HWnd; Filename: STRING): Boolean;
    PROCEDURE GetDriveLetters(AList: TStrings);
    PROCEDURE MostraDadosVersao;
    FUNCTION GetPathDWInc: TFileName;
  PUBLIC

  END;

VAR
  FrmPrincipal: TfrmPrincipal;

IMPLEMENTATION

USES
  SVN_Class,
  FileCtrl,
  ShellApi,
  IniFiles,
  StrUtils,
  Math,
  Registry;

{$R *.dfm}

FUNCTION TfrmPrincipal.RunAsAdminAndWaitForCompletion(HWnd: HWnd; Filename: STRING): Boolean;
{
  See Step 3: Redesign for UAC Compatibility (UAC)
  http://msdn.microsoft.com/en-us/library/bb756922.aspx
}
VAR
  Sei: TShellExecuteInfo;
  ExitCode: DWORD;
BEGIN
  ZeroMemory(@Sei, SizeOf(Sei));
  Sei.CbSize       := SizeOf(TShellExecuteInfo);
  Sei.Wnd          := HWnd;
  Sei.FMask        := SEE_MASK_FLAG_DDEWAIT OR SEE_MASK_FLAG_NO_UI OR SEE_MASK_NOCLOSEPROCESS;
  Sei.LpVerb       := PWideChar('runas');
  Sei.LpFile       := PWideChar(Filename);
  Sei.LpParameters := PWideChar('');
  Sei.NShow        := SW_HIDE;

  IF ShellExecuteEx(@Sei) THEN
  BEGIN
    REPEAT
      Application.ProcessMessages;
      GetExitCodeProcess(Sei.HProcess, ExitCode);
    UNTIL (ExitCode <> STILL_ACTIVE) OR Application.Terminated;
  END;
END;

PROCEDURE TfrmPrincipal.ExtrairDiretorioPacote(NomePacote: STRING);

  PROCEDURE FindDirPackage(SDir, SPacote: STRING);
  VAR
    ODirList: TSearchRec;
    IRet: Integer;
    SDirDpk: STRING;
  BEGIN
    SDir := IncludeTrailingPathDelimiter(SDir);
    IF NOT DirectoryExists(SDir) THEN
      Exit;

    IF SysUtils.FindFirst(SDir + '*.*', FaAnyFile, ODirList) = 0 THEN
    BEGIN
      TRY
        REPEAT

          IF (ODirList.Name = '.') OR (ODirList.Name = '..') OR (ODirList.Name = '__history') OR (ODirList.Name = '__recovery') THEN
            Continue;

          // if oDirList.Attr = faDirectory then
          IF DirectoryExists(SDir + ODirList.Name) THEN
            FindDirPackage(SDir + ODirList.Name, SPacote)
          ELSE
          BEGIN
            IF UpperCase(ODirList.Name) = UpperCase(SPacote) THEN
              SDirPackage := IncludeTrailingPathDelimiter(SDir);
          END;

        UNTIL SysUtils.FindNext(ODirList) <> 0;
      FINALLY
        SysUtils.FindClose(ODirList);
      END;
    END;
  END;

BEGIN
  SDirPackage := '';
  IF NomePacote = 'TBGConnection.dpk' THEN
  BEGIN
    FindDirPackage(IncludeTrailingPathDelimiter(SDirRoot), NomePacote);
  END;
  IF NomePacote = 'TBGQuery.dpk' THEN
  BEGIN
    FindDirPackage(IncludeTrailingPathDelimiter(SDirRoot), NomePacote);
  END;
  IF NomePacote = 'TBGDBExpressDriver.dpk' THEN
  BEGIN
    FindDirPackage(IncludeTrailingPathDelimiter(SDirRoot), NomePacote);
  END;
  IF NomePacote = 'TBGFiredacDriver.dpk' THEN
  BEGIN
    FindDirPackage(IncludeTrailingPathDelimiter(SDirRoot), NomePacote);
  END;
  IF NomePacote = 'TBGUniDacDriver.dpk' THEN
  BEGIN
    FindDirPackage(IncludeTrailingPathDelimiter(SDirRoot), NomePacote);
  END;
  IF NomePacote = 'TBGZeosDriver.dpk' THEN
  BEGIN
    FindDirPackage(IncludeTrailingPathDelimiter(SDirRoot), NomePacote);
  END;
  IF NomePacote = 'TBGRestDWDriver.dpk' THEN
  BEGIN
    FindDirPackage(IncludeTrailingPathDelimiter(SDirRoot), NomePacote);
  END;

  // Original
  // FindDirPackage(IncludeTrailingPathDelimiter(SDirRoot) + 'Pacotes\Delphi', NomePacote);
END;

// retornar o path do aplicativo
FUNCTION TfrmPrincipal.PathApp: STRING;
BEGIN
  Result := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)));
END;

// retornar o caminho completo para o arquivo .ini de configurações
FUNCTION TfrmPrincipal.PathArquivoIni: STRING;
VAR
  NomeApp: STRING;
BEGIN
  NomeApp := ExtractFileName(ParamStr(0));
  Result  := PathApp + ChangeFileExt(NomeApp, '.ini');
END;

// retornar o caminho completo para o arquivo de logs
FUNCTION TfrmPrincipal.PathArquivoLog: STRING;
BEGIN
  Result := PathApp + 'log_' + StringReplace(EdtDelphiVersion.Text, ' ', '_', [RfReplaceAll]) + '.txt';
END;

// verificar se no caminho informado já existe o .svn indicando que o
// checkout já foi feito no diretorio
FUNCTION TfrmPrincipal.IsCheckOutJaFeito(CONST ADiretorio: STRING): Boolean;
BEGIN
  Result := DirectoryExists(IncludeTrailingPathDelimiter(ADiretorio) + '.svn')
END;

procedure TfrmPrincipal.JvCreateProcess1ErrorRawRead(Sender: TObject;
  const S: string);
begin

end;

// retorna o diretório de sistema atual
FUNCTION TfrmPrincipal.PathSystem: STRING;
VAR
  StrTmp: ARRAY [0 .. MAX_PATH] OF Char;
  DirWindows: STRING;
CONST
  SYS_64 = 'SysWOW64';
  SYS_32 = 'System32';
BEGIN
  Result := '';

  // SetLength(strTmp, MAX_PATH);
  IF Windows.GetWindowsDirectory(StrTmp, MAX_PATH) > 0 THEN
  BEGIN
    DirWindows := Trim(StrPas(StrTmp));
    DirWindows := IncludeTrailingPathDelimiter(DirWindows);

    IF DirectoryExists(DirWindows + SYS_64) THEN
      Result := DirWindows + SYS_64
    ELSE IF DirectoryExists(DirWindows + SYS_32) THEN
      Result := DirWindows + SYS_32
    ELSE
      RAISE EFileNotFoundException.Create('Diretório de sistema não encontrado.');
  END
  ELSE
    RAISE EFileNotFoundException.Create('Ocorreu um erro ao tentar obter o diretório do windows.');
END;

FUNCTION TfrmPrincipal.RegistrarActiveXServer(CONST AServerLocation: STRING; CONST ARegister: Boolean): Boolean;
VAR
  ServerDllRegisterServer: FUNCTION: HResult; STDCALL;
  ServerDllUnregisterServer: FUNCTION: HResult; STDCALL;
  ServerHandle: THandle;

  PROCEDURE UnloadServerFunctions;
  BEGIN
    @ServerDllRegisterServer   := NIL;
    @ServerDllUnregisterServer := NIL;
    FreeLibrary(ServerHandle);
  END;

  FUNCTION LoadServerFunctions: Boolean;
  BEGIN
    Result       := False;
    ServerHandle := SafeLoadLibrary(AServerLocation);

    IF (ServerHandle <> 0) THEN
    BEGIN
      @ServerDllRegisterServer   := GetProcAddress(ServerHandle, 'DllRegisterServer');
      @ServerDllUnregisterServer := GetProcAddress(ServerHandle, 'DllUnregisterServer');

      IF (@ServerDllRegisterServer = NIL) OR (@ServerDllUnregisterServer = NIL) THEN
        UnloadServerFunctions
      ELSE
        Result := True;
    END;
  END;

BEGIN
  Result := False;
  TRY
    IF LoadServerFunctions THEN
      TRY
        IF ARegister THEN
          Result := ServerDllRegisterServer = S_OK
        ELSE
          Result := ServerDllUnregisterServer = S_OK;
      FINALLY
        UnloadServerFunctions;
      END;
  EXCEPT
  END;
END;

PROCEDURE TfrmPrincipal.CopiarArquivoTo(ADestino: TDestino; CONST ANomeArquivo: STRING);
VAR
  PathOrigem: STRING;
  PathDestino: STRING;
  DirSystem: STRING;
  DirDW: STRING;
BEGIN
  CASE ADestino OF
    TdSystem:
      DirSystem := Trim(PathSystem);
    TdDelphi:
      DirSystem := SPathBin;
  END;

  DirDW := IncludeTrailingPathDelimiter(EdtDirDestino.Text);

  IF DirSystem <> EmptyStr THEN
    DirSystem := IncludeTrailingPathDelimiter(DirSystem)
  ELSE
    RAISE EFileNotFoundException.Create('Diretório de sistema não encontrado.');

  PathOrigem  := DirDW + 'DLLs\' + ANomeArquivo;
  PathDestino := DirSystem + ExtractFileName(ANomeArquivo);

  IF FileExists(PathOrigem) AND NOT(FileExists(PathDestino)) THEN
  BEGIN
    IF NOT CopyFile(PWideChar(PathOrigem), PWideChar(PathDestino), True) THEN
    BEGIN
      RAISE EFilerError.CreateFmt('Ocorreu o seguinte erro ao tentar copiar o arquivo "%s": %d - %s', [ANomeArquivo, GetLastError, SysErrorMessage(GetLastError)]);
    END;
  END;
END;

// ler o arquivo .ini de configurações e setar os campos com os valores lidos
PROCEDURE TfrmPrincipal.LerConfiguracoes;
VAR
  ArqIni: TIniFile;
  I: Integer;
BEGIN
  ArqIni := TIniFile.Create(PathArquivoIni);
  TRY
    EdtDirDestino.Text    := ExtractFilePath(ParamStr(0));
    CkbFecharTortoise.Checked   := ArqIni.ReadBool('CONFIG', 'FecharTortoise', True);
    ChkDeixarSomenteLIB.Checked := ArqIni.ReadBool('CONFIG', 'DexarSomenteLib', False);

    IF Trim(EdtDelphiVersion.Text) = '' THEN
      EdtDelphiVersion.ItemIndex := 0;

    EdtDelphiVersionChange(EdtDelphiVersion);

    FOR I                         := 0 TO FrameDpk.Pacotes.Count - 1 DO
      FrameDpk.Pacotes[I].Checked := ArqIni.ReadBool('PACOTES', FrameDpk.Pacotes[I].Caption, False);
  FINALLY
    ArqIni.Free;
  END;
END;

PROCEDURE TfrmPrincipal.MostraDadosVersao;
BEGIN
  // mostrar ao usuário as informações de compilação
  LbInfo.Clear;
  WITH LbInfo.Items DO
  BEGIN
    Clear;
    Add(EdtDelphiVersion.Text + ' ' + EdtPlatform.Text);
    Add('Dir. Instalação  : ' + EdtDirDestino.Text);
    Add('Dir. Bibliotecas : ' + SDirLibrary);
  END;
END;

// gravar as configurações efetuadas pelo usuário
PROCEDURE TfrmPrincipal.GravarConfiguracoes;
VAR
  ArqIni: TIniFile;
  I: Integer;
BEGIN
  ArqIni := TIniFile.Create(PathArquivoIni);
  TRY
    ArqIni.WriteBool('CONFIG', 'FecharTortoise', CkbFecharTortoise.Checked);
    ArqIni.WriteBool('CONFIG', 'DexarSomenteLib', ChkDeixarSomenteLIB.Checked);
    FOR I := 0 TO FrameDpk.Pacotes.Count - 1 DO
      ArqIni.WriteBool('PACOTES', FrameDpk.Pacotes[I].Caption, FrameDpk.Pacotes[I].Checked);
  FINALLY
    ArqIni.Free;
  END;
END;

procedure TfrmPrincipal.imgLogomarcaClick(Sender: TObject);
begin

end;

// criação dos diretórios necessários
PROCEDURE TfrmPrincipal.CreateDirectoryLibrarysNotExist;
BEGIN
  // Checa se existe diretório da plataforma
  IF NOT DirectoryExists(SDirLibrary) THEN
    ForceDirectories(SDirLibrary);
  IF NOT DirectoryExists(SDirLibrary + '\Debug') THEN
    ForceDirectories(SDirLibrary + '\Debug');
END;

PROCEDURE TfrmPrincipal.DeixarSomenteLib;
  PROCEDURE Copiar(CONST Extensao: STRING);
  VAR
    ListArquivos: TStringDynArray;
    Arquivo: STRING;
    I: Integer;
  BEGIN
    ListArquivos := TDirectory.GetFiles(IncludeTrailingPathDelimiter(SDirRoot) + 'source', Extensao, TSearchOption.SoAllDirectories);
    FOR I        := LOW(ListArquivos) TO HIGH(ListArquivos) DO
    BEGIN
      Arquivo := ExtractFileName(ListArquivos[I]);
      CopyFile(PWideChar(ListArquivos[I]), PWideChar(IncludeTrailingPathDelimiter(SDirLibrary) + Arquivo), False);
    END;
  END;

BEGIN
  // remover os path com o segundo parametro
  //
  FindDirs(IncludeTrailingPathDelimiter(SDirRoot));
  Copiar('*.dcr');
  Copiar('*.res');
  Copiar('*.dfm');
  Copiar('*.ini');
  Copiar('*.inc');
  //
  // original -> FindDirs(IncludeTrailingPathDelimiter(SDirRoot) + 'Fontes', False);
  //
  // Copiar('*.dcr');
  // Copiar('*.res');
  // Copiar('*.dfm');
  // Copiar('*.ini');
  // Copiar('*.inc');
END;

PROCEDURE TfrmPrincipal.AddLibraryPathToDelphiPath(CONST APath: STRING; CONST AProcurarRemover: STRING);
CONST
  Cs: PChar = 'Environment Variables';
VAR
  LParam, WParam: Integer;
  AResult: Cardinal;
  ListaPaths: TStringList;
  I: Integer;
  PathsAtuais: STRING;
  PathFonte: STRING;
BEGIN
  WITH OTBG.Installations[IVersion] DO
  BEGIN
    // tentar ler o path configurado na ide do delphi, se não existir ler
    // a atual para complementar e fazer o override
    PathsAtuais := Trim(EnvironmentVariables.Values['PATH']);
    IF PathsAtuais = '' THEN
      PathsAtuais := GetEnvironmentVariable('PATH');

    // manipular as strings
    ListaPaths := TStringList.Create;
    TRY
      ListaPaths.Clear;
      ListaPaths.Delimiter       := ';';
      ListaPaths.StrictDelimiter := True;
      ListaPaths.DelimitedText   := PathsAtuais;

      // verificar se existe algo do TBG e remover do environment variable PATH do delphi
      IF Trim(AProcurarRemover) <> '' THEN
      BEGIN
        FOR I := ListaPaths.Count - 1 DOWNTO 0 DO
        BEGIN
          IF Pos(AnsiUpperCase(AProcurarRemover), AnsiUpperCase(ListaPaths[I])) > 0 THEN
            ListaPaths.Delete(I);
        END;
      END;

      // adicionar o path
      ListaPaths.Add(APath);

      // escrever a variavel no override da ide
      ConfigData.WriteString(Cs, 'PATH', ListaPaths.DelimitedText);

      // enviar um broadcast de atualização para o windows
      WParam := 0;
      LParam := LongInt(Cs);
      SendMessageTimeout(HWND_BROADCAST, WM_SETTINGCHANGE, WParam, LParam, SMTO_NORMAL, 4000, AResult);
      IF AResult <> 0 THEN
        RAISE Exception.Create('Ocorreu um erro ao tentar configurar o path: ' + SysErrorMessage(AResult));
    FINALLY
      ListaPaths.Free;
    END;
  END;
END;

PROCEDURE TfrmPrincipal.FindDirs(ADirRoot: STRING; BAdicionar: Boolean = True);
VAR
  ODirList: TSearchRec;

  FUNCTION EProibido(CONST ADir: STRING): Boolean;
  CONST
    LISTA_PROIBIDOS: ARRAY [0 .. 5] OF STRING = ('quick', 'rave', 'laz', 'VerificarNecessidade', '__history', '__recovery');
  VAR
    Str: STRING;
  BEGIN
    Result := False;
    FOR Str IN LISTA_PROIBIDOS DO
    BEGIN
      Result := Pos(AnsiUpperCase(Str), AnsiUpperCase(ADir)) > 0;
      IF Result THEN
        Break;
    END;
  END;

BEGIN
  ADirRoot := IncludeTrailingPathDelimiter(ADirRoot);

  IF FindFirst(ADirRoot + '*.*', FaDirectory, ODirList) = 0 THEN
  BEGIN
    TRY
      REPEAT
        IF ((ODirList.Attr AND FaDirectory) <> 0) AND (ODirList.Name <> '.') AND (ODirList.Name <> '..') AND (NOT EProibido(ODirList.Name)) THEN
        BEGIN
          WITH OTBG.Installations[IVersion] DO
          BEGIN
            IF BAdicionar THEN
            BEGIN
              AddToLibrarySearchPath(ADirRoot + ODirList.Name, TPlatform);
              AddToLibraryBrowsingPath(ADirRoot + ODirList.Name, TPlatform);
            END
            ELSE
              RemoveFromLibrarySearchPath(ADirRoot + ODirList.Name, TPlatform);
          END;
          // -- Procura subpastas
          FindDirs(ADirRoot + ODirList.Name, BAdicionar);
        END;
      UNTIL FindNext(ODirList) <> 0;
    FINALLY
      SysUtils.FindClose(ODirList)
    END;
  END;
END;

// adicionar o paths ao library path do delphi
PROCEDURE TfrmPrincipal.AddLibrarySearchPath;
BEGIN
  WITH OTBG.Installations[IVersion] DO
  BEGIN
    // Incluir o path raiz por causa da localização do pacote
    IF FrameDpk.TBGAbstConnection_dpk.Checked THEN
    BEGIN
      AddToLibrarySearchPath(SDirRoot, bpWin32); // arquivos do projeto ou global (*.pas contidos na uses Library (DCUs) é para qualquer projeto Search apenas para o pacote (PASs))
      AddToLibrarySearchPath(IncludeTrailingPathDelimiter(SDirRoot) + 'Source', bpWin32);
      // AddToLibrarySearchPath(SDirLibrary, bpWin32); // arquivos do projeto ou global (*.pas contidos na uses Library (DCUs) é para qualquer projeto Search apenas para o pacote (PASs))
      // AddToLibrarySearchPath(SDirLibrary, bpWin32); // arquivos do projeto ou global (*.pas contidos na uses Library (DCUs) é para qualquer projeto Search apenas para o pacote (PASs))
      // AddToLibraryBrowsingPath(SDirLibrary, bpWin32); // Arquivos que devem ser usados sem ser compilados
      // AddToDebugDCUPath(SDirLibrary + '\Debug', bpWin32);

      AddToLibrarySearchPath(SDirRoot, bpWin64); // arquivos do projeto ou global (*.pas contidos na uses Library (DCUs) é para qualquer projeto Search apenas para o pacote (PASs))
      AddToLibrarySearchPath(IncludeTrailingPathDelimiter(SDirRoot) + 'Source', bpWin64);
      // AddToLibrarySearchPath(SDirLibrary, bpWin64); // arquivos do projeto ou global (*.pas contidos na uses Library (DCUs) é para qualquer projeto Search apenas para o pacote (PASs))
      // AddToLibrarySearchPath(SDirLibrary, bpWin64); // arquivos do projeto ou global (*.pas contidos na uses Library (DCUs) é para qualquer projeto Search apenas para o pacote (PASs))
      // AddToLibraryBrowsingPath(SDirLibrary, bpWin64); // Arquivos que devem ser usados sem ser compilados
      // AddToDebugDCUPath(SDirLibrary + '\Debug', bpWin64);

      //AddToLibrarySearchPath(SDirRoot, bpOSX32); // arquivos do projeto ou global (*.pas contidos na uses Library (DCUs) é para qualquer projeto Search apenas para o pacote (PASs))
      // AddToLibrarySearchPath(SDirLibrary, bpOSX32); // arquivos do projeto ou global (*.pas contidos na uses Library (DCUs) é para qualquer projeto Search apenas para o pacote (PASs))
      // AddToLibrarySearchPath(SDirLibrary, bpOSX32); // arquivos do projeto ou global (*.pas contidos na uses Library (DCUs) é para qualquer projeto Search apenas para o pacote (PASs))
      // AddToLibraryBrowsingPath(SDirLibrary, bpOSX32); // Arquivos que devem ser usados sem ser compilados
      // AddToDebugDCUPath(SDirLibrary + '\Debug', bpOSX32);
    END;
  END;

  LstMsgInstalacao.Items.Add('Adicionar à library path ao path do Windows: ' + SDirLibrary);
  AddLibraryPathToDelphiPath(SDirLibrary, 'Source');
END;

// setar a plataforma de compilação
PROCEDURE TfrmPrincipal.SetPlatformSelected;
VAR
  SVersao: STRING;
  STipo: STRING;
BEGIN
  IVersion := EdtDelphiVersion.ItemIndex;
  SVersao  := AnsiUpperCase(OTBG.Installations[IVersion].VersionNumberStr);
  SDirRoot := IncludeTrailingPathDelimiter(EdtDirDestino.Text);

  STipo := 'Lib\Delphi\';

  IF EdtPlatform.ItemIndex = 0 THEN // Win32
  BEGIN
    TPlatform   := bpWin32;
    SDirLibrary := SDirRoot + STipo + SVersao;
  END
  ELSE IF EdtPlatform.ItemIndex = 1 THEN // Win64
  BEGIN
    TPlatform   := bpWin64;
    SDirLibrary := SDirRoot + STipo + SVersao + '\Win64';
  END;
END;

// Evento disparado a cada ação do instalador
PROCEDURE TfrmPrincipal.OutputCallLine(CONST Text: STRING);
BEGIN
  // remover a warnings de conversão de string (delphi 2010 em diante)
  // as diretivas -W e -H não removem estas mensagens
  IF (Pos('Warning: W1057', Text) <= 0) AND ((Pos('Warning: W1058', Text) <= 0)) THEN
    WriteToTXT(PathArquivoLog, Text);
END;

// evento para setar os parâmetros do compilador antes de compilar
PROCEDURE TfrmPrincipal.BeforeExecute(Sender: TJclBorlandCommandLineTool);
BEGIN
  // limpar os parâmetros do compilador
  Sender.Options.Clear;

  // não utilizar o dcc32.cfg
  IF OTBG.Installations[IVersion].SupportsNoConfig THEN
    Sender.Options.Add('--no-config');

  // -B = Build all units
  Sender.Options.Add('-B');
  // O+ = Optimization
  Sender.Options.Add('-$O-');
  // W- = Generate stack frames
  Sender.Options.Add('-$W+');
  // Y+ = Symbol reference info
  Sender.Options.Add('-$Y-');
  // -M = Make modified units
  Sender.Options.Add('-M');
  // -Q = Quiet compile
  Sender.Options.Add('-Q');
  // não mostrar warnings
  Sender.Options.Add('-H-');
  // não mostrar hints
  Sender.Options.Add('-W-');
  // -D<syms> = Define conditionals
  Sender.Options.Add('-DRELEASE');
  // -U<paths> = Unit directories
  Sender.AddPathOption('U', OTBG.Installations[IVersion].LibFolderName[TPlatform]);
  Sender.AddPathOption('U', OTBG.Installations[IVersion].LibrarySearchPath[TPlatform]);
  Sender.AddPathOption('U', SDirLibrary);
  // -I<paths> = Include directories
  Sender.AddPathOption('I', OTBG.Installations[IVersion].LibrarySearchPath[TPlatform]);
  // -R<paths> = Resource directories
  Sender.AddPathOption('R', OTBG.Installations[IVersion].LibrarySearchPath[TPlatform]);
  // -N0<path> = unit .dcu output directory
  Sender.AddPathOption('N0', SDirLibrary);
  Sender.AddPathOption('LE', SDirLibrary);
  Sender.AddPathOption('LN', SDirLibrary);

  WITH OTBG.Installations[IVersion] DO
  BEGIN
    // -- Path de outros componentespara necessários
    // Sender.AddPathOption('U', OTBG.Installations[IVersion].RootDir + 'caminho da lib do pacote');
    // -- Na versão XE2 por motivo da nova tecnologia FireMonkey, deve-se adicionar
    // -- os prefixos dos nomes, para identificar se será compilado para VCL ou FMX
    IF VersionNumberStr = 'd16' THEN
      Sender.Options.Add('-NSData.Win;Datasnap.Win;Web.Win;Soap.Win;Xml.Win;Bde;Vcl;Vcl.Imaging;Vcl.Touch;Vcl.Samples;Vcl.Shell;System;Xml;Data;Datasnap;Web;Soap;Winapi;System.Win');
    IF MatchText(VersionNumberStr, ['d17', 'd18', 'd19', 'd20', 'd21', 'd22', 'd23', 'd24', 'd25']) THEN
      Sender.Options.Add('-NSWinapi;System.Win;Data.Win;Datasnap.Win;Web.Win;Soap.Win;Xml.Win;Bde;System;Xml;Data;Datasnap;Web;Soap;Vcl;Vcl.Imaging;Vcl.Touch;Vcl.Samples;Vcl.Shell');
  END;
END;

PROCEDURE TfrmPrincipal.FormCreate(Sender: TObject);
VAR
  IFor: Integer;
BEGIN
  IVersion    := -1;
  SDirRoot    := '';
  SDirLibrary := '';
  SDirPackage := '';
  PastaTBG    := '';

  OTBG := TJclBorRADToolInstallations.Create;

  // popular o combobox de versões do delphi instaladas na máquina
  FOR IFor := 0 TO OTBG.Count - 1 DO
  BEGIN
    IF OTBG.Installations[IFor].VersionNumberStr = 'd3' THEN
      EdtDelphiVersion.Items.Add('Delphi 3')
    ELSE IF OTBG.Installations[IFor].VersionNumberStr = 'd4' THEN
      EdtDelphiVersion.Items.Add('Delphi 4')
    ELSE IF OTBG.Installations[IFor].VersionNumberStr = 'd5' THEN
      EdtDelphiVersion.Items.Add('Delphi 5')
    ELSE IF OTBG.Installations[IFor].VersionNumberStr = 'd6' THEN
    BEGIN
      EdtDelphiVersion.Items.Add('Delphi 6');
      PastaTBG := OTBG.Installations[IFor].VersionNumberStr;
    END
    ELSE IF OTBG.Installations[IFor].VersionNumberStr = 'd7' THEN
    BEGIN
      EdtDelphiVersion.Items.Add('Delphi 7');
      PastaTBG := OTBG.Installations[IFor].VersionNumberStr;
    END
    ELSE IF OTBG.Installations[IFor].VersionNumberStr = 'd9' THEN
    BEGIN
      EdtDelphiVersion.Items.Add('Delphi 2005');
    END
    ELSE IF OTBG.Installations[IFor].VersionNumberStr = 'd10' THEN
    BEGIN
      EdtDelphiVersion.Items.Add('Delphi 2006');
    END
    ELSE IF OTBG.Installations[IFor].VersionNumberStr = 'd11' THEN
    BEGIN
      EdtDelphiVersion.Items.Add('Delphi 2007');
    END
    ELSE IF OTBG.Installations[IFor].VersionNumberStr = 'd12' THEN
    BEGIN
      EdtDelphiVersion.Items.Add('Delphi 2009');
    END
    ELSE IF OTBG.Installations[IFor].VersionNumberStr = 'd14' THEN
    BEGIN
      EdtDelphiVersion.Items.Add('Delphi 2010');
      PastaTBG := 'D2010';
    END
    ELSE IF OTBG.Installations[IFor].VersionNumberStr = 'd15' THEN
    BEGIN
      EdtDelphiVersion.Items.Add('Delphi XE');
      PastaTBG := 'XE';
    END
    ELSE IF OTBG.Installations[IFor].VersionNumberStr = 'd16' THEN
    BEGIN
      EdtDelphiVersion.Items.Add('Delphi XE2');
      PastaTBG := 'XE2';
    END
    ELSE IF OTBG.Installations[IFor].VersionNumberStr = 'd17' THEN
    BEGIN
      EdtDelphiVersion.Items.Add('Delphi XE3');
    END
    ELSE IF OTBG.Installations[IFor].VersionNumberStr = 'd18' THEN
    BEGIN
      EdtDelphiVersion.Items.Add('Delphi XE4');
    END
    ELSE IF OTBG.Installations[IFor].VersionNumberStr = 'd19' THEN
    BEGIN
      EdtDelphiVersion.Items.Add('Delphi XE5');
      PastaTBG := 'XE5';
    END
    ELSE IF OTBG.Installations[IFor].VersionNumberStr = 'd20' THEN
    BEGIN
      EdtDelphiVersion.Items.Add('Delphi XE6');
      PastaTBG := 'XE6';
    END
    ELSE IF OTBG.Installations[IFor].VersionNumberStr = 'd21' THEN
    BEGIN
      EdtDelphiVersion.Items.Add('Delphi XE7');
      PastaTBG := 'XE7';
    END
    ELSE IF OTBG.Installations[IFor].VersionNumberStr = 'd22' THEN
    BEGIN
      EdtDelphiVersion.Items.Add('Delphi XE8');
      PastaTBG := 'XE8';
    END
    ELSE IF OTBG.Installations[IFor].VersionNumberStr = 'd23' THEN
    BEGIN
      EdtDelphiVersion.Items.Add('Delphi 10 Seattle');
      PastaTBG := 'Seattle';
    END
    ELSE IF OTBG.Installations[IFor].VersionNumberStr = 'd24' THEN
    BEGIN
      EdtDelphiVersion.Items.Add('Delphi 10.1 Berlin');
      PastaTBG := 'Berlin';
    END
    ELSE IF OTBG.Installations[IFor].VersionNumberStr = 'd25' THEN
    BEGIN
      EdtDelphiVersion.Items.Add('Delphi 10.2 Tokyo');
      PastaTBG := 'Tokyo';
    END;

    // -- Evento disparado antes de iniciar a execução do processo.
    OTBG.Installations[IFor].DCC32.OnBeforeExecute := BeforeExecute;

    // -- Evento para saidas de mensagens.
    OTBG.Installations[IFor].OutputCallback := OutputCallLine;
  END;
  ClbDelphiVersion.Items.Text := EdtDelphiVersion.Items.Text;

  //IF EdtDelphiVersion.Items.Count > 0 THEN
  //BEGIN
  //  EdtDelphiVersion.ItemIndex := 0;
  //  IVersion                   := 0;
  //END;

  LerConfiguracoes;
END;

PROCEDURE TfrmPrincipal.FormClose(Sender: TObject; VAR Action: TCloseAction);
BEGIN
  OTBG.Free;
END;

PROCEDURE TfrmPrincipal.RemoverDiretoriosEPacotesAntigos;
VAR
  ListaPaths: TStringList;
  I: Integer;
BEGIN
  ListaPaths := TStringList.Create;
  TRY
    ListaPaths.StrictDelimiter := True;
    ListaPaths.Delimiter       := ';';
    WITH OTBG.Installations[IVersion] DO
    BEGIN
      // remover do search path
      ListaPaths.Clear;
      ListaPaths.DelimitedText := RawLibrarySearchPath[TPlatform];
      FOR I                    := ListaPaths.Count - 1 DOWNTO 0 DO
      BEGIN
        IF Pos('TBGConnection', AnsiUpperCase(ListaPaths[I])) > 0 THEN
          ListaPaths.Delete(I);
      END;
      RawLibrarySearchPath[TPlatform] := ListaPaths.DelimitedText;
      // remover do browse path
      ListaPaths.Clear;
      ListaPaths.DelimitedText := RawLibraryBrowsingPath[TPlatform];
      FOR I                    := ListaPaths.Count - 1 DOWNTO 0 DO
      BEGIN
        IF Pos('TBGConnection', AnsiUpperCase(ListaPaths[I])) > 0 THEN
          ListaPaths.Delete(I);
      END;
      RawLibraryBrowsingPath[TPlatform] := ListaPaths.DelimitedText;
      // remover do Debug DCU path
      ListaPaths.Clear;
      ListaPaths.DelimitedText := RawDebugDCUPath[TPlatform];
      FOR I                    := ListaPaths.Count - 1 DOWNTO 0 DO
      BEGIN
        IF Pos('TBGConnection', AnsiUpperCase(ListaPaths[I])) > 0 THEN
          ListaPaths.Delete(I);
      END;
      RawDebugDCUPath[TPlatform] := ListaPaths.DelimitedText;
      // remover pacotes antigos
      FOR I := IdePackages.Count - 1 DOWNTO 0 DO
      BEGIN
        IF Pos('TBGConnection', AnsiUpperCase(IdePackages.PackageFileNames[I])) > 0 THEN
          IdePackages.RemovePackage(IdePackages.PackageFileNames[I]);
      END;
    END;
  FINALLY
    ListaPaths.Free;
  END;
END;

PROCEDURE TfrmPrincipal.GetDriveLetters(AList: TStrings);
VAR
  VDrivesSize: Cardinal;
  VDrives: ARRAY [0 .. 128] OF Char;
  VDrive: PChar;
  VDriveType: Cardinal;
BEGIN
  AList.BeginUpdate;
  TRY
    // clear the list from possible leftover from prior operations
    AList.Clear;
    VDrivesSize := GetLogicalDriveStrings(SizeOf(VDrives), VDrives);
    IF VDrivesSize = 0 THEN
      Exit;

    VDrive := VDrives;
    WHILE VDrive^ <> #0 DO
    BEGIN
      // adicionar somente drives fixos
      VDriveType := GetDriveType(VDrive);
      IF VDriveType = DRIVE_FIXED THEN
        AList.Add(StrPas(VDrive));

      Inc(VDrive, SizeOf(VDrive));
    END;
  FINALLY
    AList.EndUpdate;
  END;
END;

PROCEDURE TfrmPrincipal.RemoverArquivosAntigosDoDisco;
VAR
  PathBat: STRING;
  DriverList: TStringList;
  ConteudoArquivo: STRING;
  I: Integer;
BEGIN
  PathBat := ExtractFilePath(ParamStr(0)) + 'apagarTBG.bat';

  // listar driver para montar o ConteudoArquivo
  DriverList := TStringList.Create;
  TRY
    GetDriveLetters(DriverList);
    ConteudoArquivo := '@echo off' + SLineBreak;
    FOR I           := 0 TO DriverList.Count - 1 DO
    BEGIN
      ConteudoArquivo := ConteudoArquivo + StringReplace(DriverList[I], '\', '', []) + SLineBreak;
      ConteudoArquivo := ConteudoArquivo + 'cd\' + SLineBreak;
      ConteudoArquivo := ConteudoArquivo + 'del ';
      ConteudoArquivo := ConteudoArquivo + ' TBGAbstConnection.dcp';
      ConteudoArquivo := ConteudoArquivo + ' TBGAbstConnection.bpl';
      ConteudoArquivo := ConteudoArquivo + ' TBGAbstConnection*.bpi';
      ConteudoArquivo := ConteudoArquivo + ' TBGAbstConnection*.lib';
      ConteudoArquivo := ConteudoArquivo + ' TBGAbstConnection*.hpp';

      ConteudoArquivo := ConteudoArquivo + ' TBGQuery.dcp';
      ConteudoArquivo := ConteudoArquivo + ' TBGQuery.bpl';
      ConteudoArquivo := ConteudoArquivo + ' TBGQuery*.bpi';
      ConteudoArquivo := ConteudoArquivo + ' TBGQuery*.lib';
      ConteudoArquivo := ConteudoArquivo + ' TBGQuery*.hpp';

      ConteudoArquivo := ConteudoArquivo + ' TBG*Driver.dcp';
      ConteudoArquivo := ConteudoArquivo + ' TBG*Driver.bpl';
      ConteudoArquivo := ConteudoArquivo + ' TBG*Driver.bpi';
      ConteudoArquivo := ConteudoArquivo + ' TBG*Driver.lib';
      ConteudoArquivo := ConteudoArquivo + ' TBG*Driver.hpp';

      ConteudoArquivo := ConteudoArquivo + ' /s' + SLineBreak;
      ConteudoArquivo := ConteudoArquivo + SLineBreak;
    END;

    WriteToTXT(PathBat, ConteudoArquivo, False);
  FINALLY
    DriverList.Free;
  END;

  RunAsAdminAndWaitForCompletion(Handle, PathBat);
END;

FUNCTION TfrmPrincipal.GetPathDWInc: TFileName;
BEGIN
  Result := ''; //IncludeTrailingPathDelimiter(EdtDirDestino.Text) + 'CORE\Source\uRESTDW.inc';
END;

// botão de compilação e instalação dos pacotes selecionados no treeview
PROCEDURE TfrmPrincipal.btnInstalarTBGClick(Sender: TObject);
VAR
  IDpk: Integer;
  BRunOnly: Boolean;
  NomePacote: STRING;
  Cabecalho: STRING;
  IListaVer: Integer;

  PROCEDURE Logar(CONST AString: STRING);
  BEGIN
    LstMsgInstalacao.Items.Add(AString);
    LstMsgInstalacao.ItemIndex := LstMsgInstalacao.Count - 1;
    Application.ProcessMessages;

    WriteToTXT(PathArquivoLog, AString);
  END;

  PROCEDURE MostrarMensagemInstalado(CONST AMensagem: STRING; CONST AErro: STRING = '');
  VAR
    Msg: STRING;
  BEGIN

    IF Trim(AErro) = EmptyStr THEN
    BEGIN
      CASE SDestino OF
        TdSystem:
          Msg := Format(AMensagem + ' em "%s"', [PathSystem]);
        TdDelphi:
          Msg := Format(AMensagem + ' em "%s"', [SPathBin]);
        TdNone:
          Msg := 'Tipo de destino "nenhum" não aceito!';
      END;
    END
    ELSE
    BEGIN
      Inc(FCountErros);

      CASE SDestino OF
        TdSystem:
          Msg := Format(AMensagem + ' em "%s": "%s"', [PathSystem, AErro]);
        TdDelphi:
          Msg := Format(AMensagem + ' em "%s": "%s"', [SPathBin, AErro]);
        TdNone:
          Msg := 'Tipo de destino "nenhum" não aceito!';
      END;
    END;

    WriteToTXT(PathArquivoLog, '');
    Logar(Msg);
  END;

  PROCEDURE IncrementaBarraProgresso;
  BEGIN
    PgbInstalacao.Position := PgbInstalacao.Position + 1;
    Application.ProcessMessages;
  END;

  PROCEDURE DesligarDefineDWInc(CONST ADefineName: STRING; CONST ADesligar: Boolean);
  VAR
    F: TStringList;
    I: Integer;
  BEGIN
    F := TStringList.Create;
    TRY
      F.LoadFromFile(GetPathDWInc);
      FOR I := 0 TO F.Count - 1 DO
      BEGIN
        IF Pos(ADefineName.ToUpper, F[I].ToUpper) > 0 THEN
        BEGIN
          IF ADesligar THEN
          BEGIN
            F[I] := '{.$DEFINE ' + ADefineName + '}';
          END
          ELSE
          BEGIN
            F[I] := '{$DEFINE ' + ADefineName + '}';
          END;

          Break;
        END;
      END;
      F.SaveToFile(GetPathDWInc);
    FINALLY
      F.Free;
    END;
  END;

BEGIN

  FOR IListaVer := 0 TO ClbDelphiVersion.Count - 1 DO
  BEGIN
    // Instalar nas versões marcadas, permitindo várias versões do Delphi.
    IF ClbDelphiVersion.Checked[IListaVer] THEN
    BEGIN
      LstMsgInstalacao.Clear;
      PgbInstalacao.Position := 0;

      // Define a versão marcada no combobox.
      EdtDelphiVersion.ItemIndex := IListaVer;
      EdtDelphiVersionChange(EdtDelphiVersion);

      // define dados da plataforna selecionada
      SetPlatformSelected;

      // mostra na tela os dados da versão a ser instalada
      MostraDadosVersao();

      BtnInstalarTBG.Enabled := False;
      WizPgInstalacao.EnableButton(BkNext, False);
      WizPgInstalacao.EnableButton(BkBack, False);
      WizPgInstalacao.EnableButton(TJvWizardButtonKind(BkCancel), False);
      FCountErros := 0;
      TRY
        Cabecalho := 'Caminho: ' + EdtDirDestino.Text + SLineBreak + 'Versão do delphi: ' + EdtDelphiVersion.Text + ' (' + IntToStr(IVersion) + ')' + SLineBreak + 'Plataforma: ' + EdtPlatform.Text + '(' + IntToStr(Integer(TPlatform)) + ')' + SLineBreak +
          StringOfChar('=', 80);

        // Limpar o log
        LstMsgInstalacao.Clear;
        WriteToTXT(PathArquivoLog, Cabecalho, False);

        // setar barra de progresso
        PgbInstalacao.Position := 0;
        PgbInstalacao.Max      := (FrameDpk.Pacotes.Count * 2) + 6;

        // *************************************************************************
        // removendo arquivos antigos se configurado
        // *************************************************************************
        IF CkbRemoverArquivosAntigos.Checked THEN
        BEGIN
          IF Application.MessageBox('você optou por limpar arquivos antigos do TBGConnection do seu computador, essa ação pode demorar vários minutos, deseja realmente continuar com está ação?', 'Limpar', MB_YESNO + MB_DEFBUTTON2) = ID_YES THEN
          BEGIN
            Logar('Removendo arquivos antigos do disco...');
            RemoverArquivosAntigosDoDisco;
          END;
        END;
        IncrementaBarraProgresso;

        // *************************************************************************
        // remover paths do delphi
        // *************************************************************************
        Logar('Removendo diretorios e pacotes antigos instalados...');
        RemoverDiretoriosEPacotesAntigos;
        IncrementaBarraProgresso;

        // *************************************************************************
        // Cria diretório de biblioteca da versão do delphi selecionada,
        // só será criado se não existir
        // *************************************************************************
        Logar('Criando diretórios de bibliotecas...');
        CreateDirectoryLibrarysNotExist;
        IncrementaBarraProgresso;

        // *************************************************************************
        // Adiciona os paths dos fontes na versão do delphi selecionada
        // *************************************************************************
        Logar('Adicionando Library Paths...');
        AddLibrarySearchPath;
        IncrementaBarraProgresso;

        // *************************************************************************
        // compilar os pacotes primeiramente
        // *************************************************************************
        Logar('');
        Logar('COMPILANDO OS PACOTES...');
        FOR IDpk := 0 TO FrameDpk.Pacotes.Count - 1 DO
        BEGIN
          NomePacote := FrameDpk.Pacotes[IDpk].Caption;

          // Busca diretório do pacote
          ExtrairDiretorioPacote(NomePacote);

          IF (IsDelphiPackage(NomePacote)) AND (FrameDpk.Pacotes[IDpk].Checked) THEN
          BEGIN
            WriteToTXT(PathArquivoLog, '');
            // [        Pacote         ] [pasta BPL ] [pasta DCP ]
            IF OTBG.Installations[IVersion].CompilePackage(SDirPackage + NomePacote, SDirLibrary, SDirLibrary) THEN
              Logar(Format('Pacote "%s" compilado com sucesso.', [NomePacote]))
            ELSE
            BEGIN
              Inc(FCountErros);
              Logar(Format('Erro ao compilar o pacote "%s".', [NomePacote]));
              // parar no primeiro erro para evitar de compilar outros pacotes que
              // precisam do pacote que deu erro
              Break
            END;
          END;
          IncrementaBarraProgresso;
        END;

        // *************************************************************************
        // instalar os pacotes somente se não ocorreu erro na compilação e plataforma for Win32
        // *************************************************************************
        IF (EdtPlatform.ItemIndex = 0) THEN
        BEGIN
          IF (FCountErros <= 0) THEN
          BEGIN
            Logar('');
            Logar('INSTALANDO OS PACOTES...');

            FOR IDpk := 0 TO FrameDpk.Pacotes.Count - 1 DO
            BEGIN
              NomePacote := FrameDpk.Pacotes[IDpk].Caption;

              // Busca diretório do pacote
              ExtrairDiretorioPacote(NomePacote);
              IF (IsDelphiPackage(NomePacote)) AND (FrameDpk.Pacotes[IDpk].Checked) THEN
              BEGIN
                // instalar somente os pacotes de designtime
                GetDPKFileInfo(SDirPackage + NomePacote, BRunOnly);
                IF NOT BRunOnly THEN
                BEGIN
                  // se o pacote estiver marcado instalar, senão desinstalar
                  IF FrameDpk.Pacotes[IDpk].Checked THEN
                  BEGIN
                    WriteToTXT(PathArquivoLog, '');
                    IF OTBG.Installations[IVersion].InstallPackage(SDirPackage + NomePacote, SDirLibrary, SDirLibrary) THEN
                      Logar(Format('Pacote "%s" instalado com sucesso.', [NomePacote]))
                    ELSE
                    BEGIN
                      Inc(FCountErros);
                      Logar(Format('Ocorreu um erro ao instalar o pacote "%s".', [NomePacote]));
                      Break;
                    END;
                  END
                  ELSE
                  BEGIN
                    // WriteToTXT(PathArquivoLog, '');
                    // if OTBG.Installations[IVersion].UninstallPackage(SDirPackage + NomePacote, SDirLibrary, SDirLibrary) then
                    // Logar(Format('Pacote "%s" removido com sucesso...', [NomePacote]));
                  END;
                END;
              END;

              IncrementaBarraProgresso;
            END;
          END
          ELSE
          BEGIN
            Logar('');
            Logar('Abortando... Ocorreram erros na compilação dos pacotes.');
          END;
        END
        ELSE
        BEGIN
          Logar('');
          Logar('Para a plataforma de 64 bits os pacotes são somente compilados.');
        END;

        IF FCountErros > 0 THEN
        BEGIN
          IF Application.MessageBox(PWideChar('Ocorreram erros durante o processo de instalação, ' + SLineBreak + 'para maiores informações verifique o arquivo de log gerado.' + SLineBreak + SLineBreak + 'Deseja visualizar o arquivo de log gerado?'),
            'Instalação', MB_ICONQUESTION + MB_YESNO) = ID_YES THEN
          BEGIN
            BtnVisualizarLogCompilacao.Click;
            Break
          END;
        END;

        // *************************************************************************
        // não instalar outros requisitos se ocorreu erro anteriormente
        // *************************************************************************
        IF FCountErros <= 0 THEN
        BEGIN
          Logar('');
          Logar('INSTALANDO OUTROS REQUISITOS...');

          // *************************************************************************
          // deixar somente a pasta lib se for configurado assim
          // *************************************************************************
          IF ChkDeixarSomenteLIB.Checked THEN
          BEGIN
            TRY
              DeixarSomenteLib;

              MostrarMensagemInstalado('Limpeza library path com sucesso');
              MostrarMensagemInstalado('Copia dos arquivos necessário.');
            EXCEPT
              ON E: Exception DO
              BEGIN
                MostrarMensagemInstalado('Ocorreu erro ao limpar os path e copiar arquivos' + SLineBreak + E.Message)
              END;
            END;
          END;
        END;
      FINALLY
        BtnInstalarTBG.Enabled := True;
        WizPgInstalacao.EnableButton(BkBack, True);
        WizPgInstalacao.EnableButton(BkNext, FCountErros = 0);
        WizPgInstalacao.EnableButton(TJvWizardButtonKind(BkCancel), True);
      END;
    END;
  END;

  IF FCountErros = 0 THEN
  BEGIN
    Application.MessageBox(PWideChar('Pacotes compilados e instalados com sucesso! ' + SLineBreak + 'Clique em "Próximo" para finalizar a instalação.'), 'Instalação', MB_ICONINFORMATION + MB_OK);
  END;

END;

// chama a caixa de dialogo para selecionar o diretório de instalação
// seria bom que a caixa fosse aquele que possui o botão de criar pasta
PROCEDURE TfrmPrincipal.BtnSelecDirInstallClick(Sender: TObject);
VAR
  Dir: STRING;
BEGIN
  IF SelectDirectory('Selecione o diretório de instalação', '', Dir, [SdNewFolder, SdNewUI, SdValidateDir]) THEN
    EdtDirDestino.Text := Dir;
END;

// quando trocar a versão verificar se libera ou não o combo
// da plataforma de compilação
PROCEDURE TfrmPrincipal.ClbDelphiVersionClick(Sender: TObject);
BEGIN
  IF MatchText(OTBG.Installations[ClbDelphiVersion.ItemIndex].VersionNumberStr, ['d3', 'd4', 'd5', 'd6', 'd7','d9','d10', 'd11']) THEN
  BEGIN
    Application.MessageBox('Versão do delphi não suportada pelo TBGConnection.', 'Erro.', MB_OK + MB_ICONERROR);
  END;
END;

PROCEDURE TfrmPrincipal.EdtDelphiVersionChange(Sender: TObject);
BEGIN
  IVersion := EdtDelphiVersion.ItemIndex;
  SPathBin := IncludeTrailingPathDelimiter(OTBG.Installations[IVersion].BinFolderName);
  // -- Plataforma só habilita para Delphi XE2
  // -- Desabilita para versão diferente de Delphi XE2
  // edtPlatform.Enabled := OTBG.Installations[iVersion].VersionNumber >= 9;
  // if OTBG.Installations[iVersion].VersionNumber < 9 then
  EdtPlatform.ItemIndex := 0;
END;

// quando clicar em alguma das urls chamar o link mostrado no caption
PROCEDURE TfrmPrincipal.URLClick(Sender: TObject);
BEGIN
  ShellExecute(Handle, 'open', PWideChar(TLabel(Sender).Caption), '', '', 1);
END;

PROCEDURE TfrmPrincipal.WizPgInicioNextButtonClick(Sender: TObject; VAR Stop: Boolean);
BEGIN
  // Verificar se o delphi está aberto
{$IFNDEF DEBUG}
  IF OTBG.AnyInstanceRunning THEN
  BEGIN
    Stop := True;
    Application.MessageBox('Feche a IDE do delphi antes de continuar.', PWideChar(Application.Title), MB_ICONERROR + MB_OK);
  END;
{$ENDIF}
  // Verificar se o tortoise está instalado, se não estiver, não mostrar a aba de atualização
  // o usuário deve utilizar software proprio e fazer manualmente
  // pedido do forum
  WizPgObterFontes.Visible := TSVN_Class.SVNInstalled;
END;

PROCEDURE TfrmPrincipal.WizPgInstalacaoEnterPage(Sender: TObject; CONST FromPage: TJvWizardCustomPage);
VAR
  IFor: Integer;
BEGIN
  // para 64 bit somente compilar
  IF TPlatform = bpWin32 THEN // Win32
    BtnInstalarTBG.Caption := 'Instalar'
  ELSE // win64
    BtnInstalarTBG.Caption := 'Compilar';

  LbInfo.Clear;
  FOR IFor := 0 TO ClbDelphiVersion.Count - 1 DO
  BEGIN
    // Só pega os dados da 1a versão selecionada, para mostrar na tela qual vai iniciar
    IF ClbDelphiVersion.Checked[IFor] THEN
    BEGIN
      LbInfo.Items.Add('Instalar : ' + ClbDelphiVersion.Items[IFor] + ' ' + EdtPlatform.Text);
    END;
  END;
END;

PROCEDURE TfrmPrincipal.WizPgInstalacaoNextButtonClick(Sender: TObject; VAR Stop: Boolean);
BEGIN
  IF (LstMsgInstalacao.Count <= 0) THEN
  BEGIN
    Stop := True;
    Application.MessageBox('Clique no botão instalar antes de continuar.', 'Erro.', MB_OK + MB_ICONERROR);
  END;

  IF (FCountErros > 0) THEN
  BEGIN
    Stop := True;
    Application.MessageBox('Ocorreram erros durante a compilação e instalação dos pacotes, verifique.', 'Erro.', MB_OK + MB_ICONERROR);
  END;
END;

PROCEDURE TfrmPrincipal.WizPgConfiguracaoNextButtonClick(Sender: TObject; VAR Stop: Boolean);
VAR
  IFor: Integer;
  BChk: Boolean;
BEGIN
  BChk     := False;
  FOR IFor := 0 TO ClbDelphiVersion.Count - 1 DO
  BEGIN
    IF ClbDelphiVersion.Checked[IFor] THEN
      BChk := True;
  END;

  IF NOT BChk THEN
  BEGIN
    Stop := True;
    ClbDelphiVersion.SetFocus;
    Application.MessageBox('Para continuar escolha a versão do Delphi para a qual deseja instalar o TBGConnection.', 'Erro.', MB_OK + MB_ICONERROR);
  END;

  // verificar se foi informado o diretório
  IF Trim(EdtDirDestino.Text) = EmptyStr THEN
  BEGIN
    Stop := True;
    EdtDirDestino.SetFocus;
    Application.MessageBox('Diretório de instalação não foi informado.', 'Erro.', MB_OK + MB_ICONERROR);
  END;

  // prevenir plataforma em branco
  IF Trim(EdtPlatform.Text) = '' THEN
  BEGIN
    Stop := True;
    EdtPlatform.SetFocus;
    Application.MessageBox('Plataforma de compilação não foi informada.', 'Erro.', MB_OK + MB_ICONERROR);
  END;

  // Gravar as configurações em um .ini para utilizar depois
  GravarConfiguracoes;
END;

PROCEDURE TfrmPrincipal.WizPgObterFontesEnterPage(Sender: TObject; CONST FromPage: TJvWizardCustomPage);
BEGIN
  // verificar se o checkout já foi feito se sim, atualizar
  // se não fazer o checkout
  IF IsCheckOutJaFeito(EdtDirDestino.Text) THEN
  BEGIN
    LblInfoObterFontes.Caption   := 'Clique em "Atualizar" para efetuar a atualização do repositório.';
    BtnSVNCheckoutUpdate.Caption := 'Atualizar...';
    BtnSVNCheckoutUpdate.Tag     := -1;
  END
  ELSE
  BEGIN
    LblInfoObterFontes.Caption   := 'Clique em "Download" para efetuar o download do repositório.';
    BtnSVNCheckoutUpdate.Caption := 'Download...';
    BtnSVNCheckoutUpdate.Tag     := 1;
  END;
END;

PROCEDURE TfrmPrincipal.BtnSVNCheckoutUpdateClick(Sender: TObject);
BEGIN
  // chamar o método de update ou checkout conforme a necessidade
  IF TButton(Sender).Tag > 0 THEN
  BEGIN
    // criar o diretório onde será baixado o repositório
    IF NOT SysUtils.DirectoryExists(EdtDirDestino.Text) THEN
    BEGIN
      IF NOT SysUtils.ForceDirectories(EdtDirDestino.Text) THEN
      BEGIN
        RAISE EDirectoryNotFoundException.Create('Ocorreu o seguinte erro ao criar o diretório' + SLineBreak + SysErrorMessage(GetLastError));
      END;
    END;

    // checkout
    TSVN_Class.SVNTortoise_CheckOut(EdtURL.Text, EdtDirDestino.Text, CkbFecharTortoise.Checked);
  END
  ELSE
  BEGIN
    // update
    TSVN_Class.SVNTortoise_Update(EdtDirDestino.Text, CkbFecharTortoise.Checked);
  END;
END;

PROCEDURE TfrmPrincipal.BtnVisualizarLogCompilacaoClick(Sender: TObject);
BEGIN
  ShellExecute(Handle, 'open', PWideChar(PathArquivoLog), '', '', 1);
END;

PROCEDURE TfrmPrincipal.BtnWCInfoClick(Sender: TObject);
BEGIN
  // capturar informações da última revisão
  TSVN_Class.GetRevision(EdtDirDestino.Text);
  ShowMessage('Última Revisão: ' + TSVN_Class.WCInfo.Revision + SLineBreak + 'Autor: ' + TSVN_Class.WCInfo.Author + SLineBreak + 'Data: ' + TSVN_Class.WCInfo.Date);
END;

PROCEDURE TfrmPrincipal.WizPgObterFontesNextButtonClick(Sender: TObject; VAR Stop: Boolean);
VAR
  I: Integer;
  NomePacote: STRING;
BEGIN
  GravarConfiguracoes;

  // verificar se os pacotes existem antes de seguir para o próximo paso
  FOR I := 0 TO FrameDpk.Pacotes.Count - 1 DO
  BEGIN
    IF FrameDpk.Pacotes[I].Checked THEN
    BEGIN
      SDirRoot   := IncludeTrailingPathDelimiter(EdtDirDestino.Text);
      NomePacote := FrameDpk.Pacotes[I].Caption;

      ExtrairDiretorioPacote(NomePacote);
      IF Trim(SDirPackage) = '' THEN
        RAISE Exception.Create('Não foi possível retornar o diretório do pacote : ' + NomePacote);

      IF IsDelphiPackage(NomePacote) THEN
      BEGIN
        IF NOT FileExists(IncludeTrailingPathDelimiter(SDirPackage) + NomePacote) THEN
        BEGIN
          Stop := True;
          Application.MessageBox(PWideChar(Format('Pacote "%s" não encontrado, efetue novamente o download do repositório', [NomePacote])), 'Erro.', MB_ICONERROR + MB_OK);
          Break;
        END;
      END;
    END;
  END;
END;

PROCEDURE TfrmPrincipal.WizPrincipalCancelButtonClick(Sender: TObject);
BEGIN
  IF Application.MessageBox('Deseja realmente cancelar a instalação?', 'Fechar', MB_ICONQUESTION + MB_YESNO) = ID_YES THEN
  BEGIN
    Self.Close;
  END;
END;

PROCEDURE TfrmPrincipal.WizPrincipalFinishButtonClick(Sender: TObject);
BEGIN
  Self.Close;
END;

PROCEDURE TfrmPrincipal.WriteToTXT(CONST ArqTXT: STRING; ABinaryString: AnsiString; CONST AppendIfExists, AddLineBreak: Boolean);
VAR
  FS: TFileStream;
  LineBreak: AnsiString;
BEGIN
  FS := TFileStream.Create(ArqTXT, IfThen(AppendIfExists AND FileExists(ArqTXT), Integer(FmOpenReadWrite), Integer(FmCreate)) OR FmShareDenyWrite);
  TRY
    FS.Seek(0, SoFromEnd); // vai para EOF
    FS.Write(Pointer(ABinaryString)^, Length(ABinaryString));

    IF AddLineBreak THEN
    BEGIN
      LineBreak := SLineBreak;
      FS.Write(Pointer(LineBreak)^, Length(LineBreak));
    END;
  FINALLY
    FS.Free;
  END;
END;

END.
