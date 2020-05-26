{******************************************************************************}
{                       CnPack For Delphi/C++Builder                           }
{                     �й����Լ��Ŀ���Դ�������������                         }
{                   (C)Copyright 2001-2020 CnPack ������                       }
{                   ------------------------------------                       }
{                                                                              }
{            ���������ǿ�Դ���������������������� CnPack �ķ���Э������        }
{        �ĺ����·�����һ����                                                }
{                                                                              }
{            ������һ��������Ŀ����ϣ�������ã���û���κε���������û��        }
{        �ʺ��ض�Ŀ�Ķ������ĵ���������ϸ���������� CnPack ����Э�顣        }
{                                                                              }
{            ��Ӧ���Ѿ��Ϳ�����һ���յ�һ�� CnPack ����Э��ĸ��������        }
{        ��û�У��ɷ������ǵ���վ��                                            }
{                                                                              }
{            ��վ��ַ��http://www.cnpack.org                                   }
{            �����ʼ���master@cnpack.org                                       }
{                                                                              }
{******************************************************************************}

library CnWizLoader;
{* |<PRE>
================================================================================
* �������ƣ�CnPack IDE ר�Ұ�
* ��Ԫ���ƣ�CnWizard ר�� DLL ������ʵ�ֵ�Ԫ
* ��Ԫ���ߣ���Х (liuxiao@cnpack.org)
* ��    ע��
* ����ƽ̨��PWin7 + Delphi 5.0
* ���ݲ��ԣ����а汾�� Delphi
* �� �� �����õ�Ԫ���豾�ػ�
* �޸ļ�¼��2020.05.13 V1.0
*               ������Ԫ
================================================================================
|</PRE>}

uses
  SysUtils, Classes, Windows, Forms, ToolsAPI;

{$R *.RES}

const
  SCnNoCnWizardsSwitch = 'nocn';

type
  TWizardEntryPoint = function (const BorlandIDEServices: IBorlandIDEServices;
    RegisterProc: TWizardRegisterProc; var Terminate: TWizardTerminateProc): Boolean; stdcall;

  TVersionNumber = packed record
  {* �ļ��汾��}
    Major: Word;
    Minor: Word;
    Release: Word;
    Build: Word;
  end;

var
  LoaderTerminateProc: TWizardTerminateProc = nil;
  DllInst: HINST = 0;

// ȡ�ļ��汾��
function GetFileVersionNumber(const FileName: string): TVersionNumber;
var
  VersionInfoBufferSize: DWORD;
  dummyHandle: DWORD;
  VersionInfoBuffer: Pointer;
  FixedFileInfoPtr: PVSFixedFileInfo;
  VersionValueLength: UINT;
begin
  FillChar(Result, SizeOf(Result), 0);
  if not FileExists(FileName) then
    Exit;

  VersionInfoBufferSize := GetFileVersionInfoSize(PChar(FileName), dummyHandle);
  if VersionInfoBufferSize = 0 then
    Exit;

  GetMem(VersionInfoBuffer, VersionInfoBufferSize);
  try
    try
      Win32Check(GetFileVersionInfo(PChar(FileName), dummyHandle,
        VersionInfoBufferSize, VersionInfoBuffer));
      Win32Check(VerQueryValue(VersionInfoBuffer, '\',
        Pointer(FixedFileInfoPtr), VersionValueLength));
    except
      Exit;
    end;
    Result.Major := FixedFileInfoPtr^.dwFileVersionMS shr 16;
    Result.Minor := FixedFileInfoPtr^.dwFileVersionMS;
    Result.Release := FixedFileInfoPtr^.dwFileVersionLS shr 16;
    Result.Build := FixedFileInfoPtr^.dwFileVersionLS;
  finally
    FreeMem(VersionInfoBuffer);
  end;
end;

function GetWizardDll: string;
const
  RIO_13_2_RELEASE = 34749;
  XE2_UPDATE4_HOTFIX1_RELEASE = 48759;
var
  FullPath: array[0..MAX_PATH - 1] of AnsiChar;
  Dir, Exe: string;
  V: TVersionNumber;
begin
  GetModuleFileNameA(HInstance, @FullPath[0], MAX_PATH);
  Dir := ExtractFilePath(FullPath);

  // �ж� IDE ������汾��
  V := GetFileVersionNumber(Application.ExeName);
  Exe := LowerCase(ExtractFileName(Application.ExeName));

  case V.Major of
    5:
      begin
        if Pos('bcb', Exe) = 1 then
          Result := Dir + 'CnWizards_CB5.DLL'
        else
          Result := Dir + 'CnWizards_D5.DLL'
      end;
    6:
      begin
        if Pos('bcb', Exe) = 1 then
          Result := Dir + 'CnWizards_CB6.DLL'
        else
          Result := Dir + 'CnWizards_D6.DLL'
      end;
    7: Result := Dir + 'CnWizards_D7.DLL';
    9: Result := Dir + 'CnWizards_D2005.DLL';
    10: Result := Dir + 'CnWizards_D2006.DLL';
    11: Result := Dir + 'CnWizards_D2007.DLL';
    12: Result := Dir + 'CnWizards_D2009.DLL';
    14: Result := Dir + 'CnWizards_D2010.DLL';
    15: Result := Dir + 'CnWizards_DXE.DLL';
    16:
      begin
        if V.Release < XE2_UPDATE4_HOTFIX1_RELEASE then  // XE2 Update 4 Hotfix 1 ��������ǰ�İ汾
          Result := Dir + 'CnWizards_DXE2.DLL'  // TODO: Compile a XE2 Update 4 DLL
        else
          Result := Dir + 'CnWizards_DXE2.DLL';
      end;
    17: Result := Dir + 'CnWizards_DXE3.DLL';
    18: Result := Dir + 'CnWizards_DXE4.DLL';
    19: Result := Dir + 'CnWizards_DXE5.DLL';
    20: Result := Dir + 'CnWizards_DXE6.DLL';
    21: Result := Dir + 'CnWizards_DXE7.DLL';
    22: Result := Dir + 'CnWizards_DXE8.DLL';
    23: Result := Dir + 'CnWizards_D10S.DLL';
    24: Result := Dir + 'CnWizards_D101B.DLL';
    25: Result := Dir + 'CnWizards_D102T.DLL';
    26:
      begin
        if V.Release < RIO_13_2_RELEASE then  // 10.3.1 �����²�����һ�� DLL
          Result := Dir + 'CnWizards_D103R1.DLL'
        else
          Result := Dir + 'CnWizards_D103R.DLL';
      end;
    27: Result := Dir + 'CnWizards_D104S.DLL';
  end;
end;

// ������ DLL ж�غ�����ִ��ר�Ұ� DLL ��ж�ع��̲�ж��ר�Ұ� DLL
procedure LoaderTerminate;
begin
  if Assigned(LoaderTerminateProc) then
    LoaderTerminateProc();
  FreeLibrary(DllInst);
  DllInst := 0;
end;

// ������ DLL ��ʼ����ں��������ض�Ӧ�汾��ר�Ұ� DLL
function InitWizard(const BorlandIDEServices: IBorlandIDEServices;
  RegisterProc: TWizardRegisterProc;
  var Terminate: TWizardTerminateProc): Boolean; stdcall;
var
  Dll: string;
  Entry: TWizardEntryPoint;
begin
  if FindCmdLineSwitch(SCnNoCnWizardsSwitch, ['/', '-'], True) then
  begin
    Result := True;
    Exit;
  end;

  Result := False;
  Dll := GetWizardDll;

  if (Dll <> '') and FileExists(Dll) then
  begin
    DllInst := LoadLibraryA(PAnsiChar(Dll));
    if DllInst <> 0 then
    begin
      Entry := TWizardEntryPoint(GetProcAddress(DllInst, WizardEntryPoint));
      if Assigned(Entry) then
      begin
        // ���������� DLL ��ʼ������������ж�ع��̵�ָ��
        Result := Entry(BorlandIDEServices, RegisterProc, LoaderTerminateProc);
        // IDE ��ж�ع�����ָ�����ǵ�
        Terminate := LoaderTerminate;
      end;
    end;
  end;
end;

exports
  InitWizard name WizardEntryPoint;

begin
end.