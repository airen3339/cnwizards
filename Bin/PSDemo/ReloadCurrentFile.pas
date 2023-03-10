{******************************************************************************}
{                                                                              }
{                       Pascal Script Source File                              }
{                                                                              }
{             Run by RemObjects Pascal Script in CnPack IDE Wizards            }
{                                                                              }
{                                   Generated by CnPack IDE Wizards            }
{                                                                              }
{******************************************************************************}

program ReloadCurrentFile;

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ActnList, Buttons, ClipBrd, ComCtrls, ExtCtrls, ComObj, ExtDlgs, IniFiles,
  Menus, Printers, Registry, StdCtrls, TypInfo, ToolsAPI, CnDebug,
  RegExpr, ScriptEvent, CnCommon, CnWizClasses, CnWizUtils, CnWizIdeUtils,
  CnWizShortCut, CnWizOptions;

var
  ActionServices: IOTAActionServices;
  S: string;
begin
  S := CnOtaGetCurrentSourceFile;
  if not FileExists(S) then
  begin
    ErrorDlg('NO File to Reload!')
    Exit;
  end;

  ActionServices := IOTAActionServices(BorlandIDEServices);
  if ActionServices <> nil then
    if not ActionServices.ReloadFile(S) then
      ErrorDlg('Reload Failed for ' + S);
end.
 
