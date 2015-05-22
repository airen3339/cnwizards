{*******************************************************}
{                                                       }
{       Pascal Script Source File                       }
{       Run by RemObjects Pascal Script in CnWizards    }
{                                                       }
{       Generated by CnPack IDE Wizards                 }
{                                                       }
{*******************************************************}

program DesignerMenu;

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

procedure Execute(Sender: TObject);
var
  FormEditor: IOTAFormEditor;
  Component: IOTAComponent;
  I: Integer;
  S: string;
  List: TStrings;
begin
  FormEditor := CnOtaGetFormEditorFromModule(CnOtaGetCurrentModule);
  if FormEditor = nil then
  begin
    ErrorDlg('NO Designer Form Found.');
    Exit;
  end;

  List := TStringList.Create;
  for I := 0 to FormEditor.GetSelCount - 1 do
  begin
    Component := FormEditor.GetSelComponent(I);
    if (Component <> nil) and (Component.GetComponentHandle <> 0) then
    begin
      S := '';
      CnOtaGetComponentName(Component, S);
      if S <> '' then
        List.Add(S);
    end;
  end;

  if List.Count > 0 then
  begin
    Clipboard.AsText := Trim(List.Text);
    InfoDlg('Component Name(s) Copied.');
  end
  else
    ErrorDlg('NO Component Selected.');

  List.Free;
end;

var
  Executor: TCnDesignSelectionExecutor2;
begin
  InfoDlg('Will Add a Copy Name Item to the Designer Component Context Menu.');
  
  Executor := TCnDesignSelectionExecutor2.Create;
  Executor.Caption := 'Copy Component &Name';
  Executor.OnExecute := @Execute;
  RegisterDesignSelectionExecutor2(Executor);
end.
 
