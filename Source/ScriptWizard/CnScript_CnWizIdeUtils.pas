{******************************************************************************}
{                       CnPack For Delphi/C++Builder                           }
{                     中国人自己的开放源码第三方开发包                         }
{                   (C)Copyright 2001-2020 CnPack 开发组                       }
{                   ------------------------------------                       }
{                                                                              }
{            本开发包是开源的自由软件，您可以遵照 CnPack 的发布协议来修        }
{        改和重新发布这一程序。                                                }
{                                                                              }
{            发布这一开发包的目的是希望它有用，但没有任何担保。甚至没有        }
{        适合特定目的而隐含的担保。更详细的情况请参阅 CnPack 发布协议。        }
{                                                                              }
{            您应该已经和开发包一起收到一份 CnPack 发布协议的副本。如果        }
{        还没有，可访问我们的网站：                                            }
{                                                                              }
{            网站地址：http://www.cnpack.org                                   }
{            电子邮件：master@cnpack.org                                       }
{                                                                              }
{******************************************************************************}

unit CnScript_CnWizIdeUtils;
{ |<PRE>
================================================================================
* 软件名称：CnPack IDE 专家包
* 单元名称：脚本扩展 CnWizIdeUtils 注册类
* 单元作者：周劲羽 (zjy@cnpack.org)
* 备    注：该单元由 UnitParser v0.7 自动生成的文件修改而来
* 开发平台：PWinXP SP2 + Delphi 5.01
* 兼容测试：PWin9X/2000/XP + Delphi 5/6/7
* 本 地 化：该窗体中的字符串支持本地化处理方式
* 修改记录：2006.12.31 V1.0
*               创建单元
================================================================================
|</PRE>}

interface

{$I CnWizards.inc}

uses
  Windows, SysUtils, Classes, Buttons, Menus, Tabs, Forms, ToolsAPI, Controls,
  CnWizIdeUtils, uPSComponent, uPSRuntime, uPSCompiler;

type

  TPSImport_CnWizIdeUtils = class(TPSPlugin)
  public
    procedure CompileImport1(CompExec: TPSScript); override;
    procedure ExecImport1(CompExec: TPSScript; const ri: TPSRuntimeClassImporter); override;
  end;

{ compile-time registration functions }
procedure SIRegister_TCnPaletteWrapper(CL: TPSPascalCompiler);
procedure SIRegister_CnWizIdeUtils(CL: TPSPascalCompiler);

{ run-time registration functions }
procedure RIRegister_TCnPaletteWrapper(CL: TPSRuntimeClassImporter);
procedure RIRegister_CnWizIdeUtils(CL: TPSRuntimeClassImporter);
procedure RIRegister_CnWizIdeUtils_Routines(S: TPSExec);

implementation

(* === compile-time registration functions === *)

procedure SIRegister_TCnMessageViewWrapper(CL: TPSPascalCompiler);
begin
  //with RegClassS(CL,'TObject', 'TCnMessageViewWrapper') do
  with CL.AddClassN(CL.FindClass('TObject'), 'TCnMessageViewWrapper') do
  begin
    RegisterMethod('Constructor Create');
    RegisterMethod('Procedure UpdateAllItems');
    RegisterMethod('Procedure EditMessageSource');
    RegisterProperty('MessageViewForm', 'TCustomForm', iptr);
    RegisterProperty('TreeView', 'TXTreeView', iptr);
{$IFNDEF BDS}
    RegisterProperty('SelectedIndex', 'Integer', iptrw);
    RegisterProperty('MessageCount', 'Integer', iptr);
    RegisterProperty('CurrentMessage', 'string', iptr);
{$ENDIF}
    RegisterProperty('TabSet', 'TTabSet', iptr);
    RegisterProperty('TabSetVisible', 'Boolean', iptr);
    RegisterProperty('TabIndex', 'Integer', iptrw);
    RegisterProperty('TabCount', 'Integer', iptr);
    RegisterProperty('TabCaption', 'string', iptr);
    RegisterProperty('EditMenuItem', 'TMenuItem', iptr);
  end;
end;

procedure SIRegister_TCnPaletteWrapper(CL: TPSPascalCompiler);
begin
  //with RegClassS(CL,'TObject', 'TCnPaletteWrapper') do
  with CL.AddClassN(CL.FindClass('TObject'), 'TCnPaletteWrapper') do
  begin
    RegisterMethod('Constructor Create');
    RegisterMethod('Procedure BeginUpdate');
    RegisterMethod('Procedure EndUpdate');
    RegisterMethod('Function SelectComponent( const AComponent : string; const ATab : string) : Boolean');
    RegisterMethod('Function FindTab( const ATab : string) : Integer');
    RegisterProperty('SelectedIndex', 'Integer', iptrw);
    RegisterProperty('SelectedToolName', 'string', iptr);
    RegisterProperty('Selector', 'TSpeedButton', iptr);
    RegisterProperty('PalToolCount', 'Integer', iptr);
    RegisterProperty('ActiveTab', 'string', iptr);
    RegisterProperty('TabIndex', 'Integer', iptrw);
    RegisterProperty('Tabs', 'string Integer', iptr);
    RegisterProperty('TabCount', 'Integer', iptr);
    RegisterProperty('IsMultiLine', 'Boolean', iptr);
    RegisterProperty('Visible', 'Boolean', iptrw);
    RegisterProperty('Enabled', 'Boolean', iptrw);
  end;
end;

procedure SIRegister_CnWizIdeUtils(CL: TPSPascalCompiler);
begin
  CL.AddDelphiFunction('Function IdeGetEditorSelectedLines( Lines : TStringList) : Boolean');
  CL.AddDelphiFunction('Function IdeGetEditorSelectedText( Lines : TStringList) : Boolean');
  CL.AddDelphiFunction('Function IdeGetEditorSourceLines( Lines : TStringList) : Boolean');
  CL.AddDelphiFunction('Function IdeSetEditorSelectedLines( Lines : TStringList) : Boolean');
  CL.AddDelphiFunction('Function IdeSetEditorSelectedText( Lines : TStringList) : Boolean');
  CL.AddDelphiFunction('Function IdeSetEditorSourceLines( Lines : TStringList) : Boolean');
  CL.AddDelphiFunction('Function IdeInsertTextIntoEditor( const Text : string) : Boolean');
  CL.AddDelphiFunction('Function IdeEditorGetEditPos( var Col, Line : Integer) : Boolean');
  CL.AddDelphiFunction('Function IdeEditorGotoEditPos( Col, Line : Integer; Middle : Boolean) : Boolean');
  CL.AddDelphiFunction('Function IdeGetBlockIndent : Integer');
  CL.AddDelphiFunction('Function IdeGetFormDesigner( FormEditor : IOTAFormEditor) : IDesigner');
  CL.AddDelphiFunction('Function IdeGetDesignedForm( Designer : IDesigner) : TCustomForm');
  CL.AddDelphiFunction('Function IdeGetFormSelection( Selections : TList; Designer : IDesigner; ExcludeForm : Boolean) : Boolean');
  CL.AddDelphiFunction('Function IdeGetSourceByFileName( const FileName : string) : string');
  CL.AddDelphiFunction('Function IdeSetSourceByFileName( const FileName : string; Source : TStrings; OpenInIde : Boolean) : Boolean');
  CL.AddDelphiFunction('Function GetIdeMainForm : TCustomForm');
  CL.AddDelphiFunction('Function GetIdeEdition : string');
  CL.AddDelphiFunction('Function GetComponentPaletteTabControl : TTabControl');
  CL.AddDelphiFunction('Function GetNewComponentPaletteTabControl : TWinControl');
  CL.AddDelphiFunction('Function GetObjectInspectorForm : TCustomForm');
  CL.AddDelphiFunction('Function GetComponentPalettePopupMenu : TPopupMenu');
  CL.AddDelphiFunction('Function GetComponentPaletteControlBar : TControlBar');
  CL.AddDelphiFunction('Function GetIdeInsightBar : TWinControl');
  CL.AddDelphiFunction('Function GetMainMenuItemHeight : Integer');
  CL.AddDelphiFunction('Function IsIdeEditorForm( AForm : TCustomForm) : Boolean');
  CL.AddDelphiFunction('Function IsIdeDesignForm( AForm : TCustomForm) : Boolean');
  CL.AddDelphiFunction('Procedure BringIdeEditorFormToFront');
  CL.AddDelphiFunction('Function IDEIsCurrentWindow : Boolean');
  CL.AddDelphiFunction('Function GetInstallDir : string');
{$IFDEF BDS}
  CL.AddDelphiFunction('Function GetBDSUserDataDir : string');
{$ENDIF}
  CL.AddDelphiFunction('Procedure GetProjectLibPath( Paths : TStrings)');
  CL.AddDelphiFunction('Function GetFileNameFromModuleName( AName : string; AProject : IOTAProject) : string');
  CL.AddDelphiFunction('Function CnOtaGetVersionInfoKeys(Project: IOTAProject) : TStrings');
  CL.AddDelphiFunction('Procedure GetLibraryPath( Paths : TStrings; IncludeProjectPath : Boolean)');
  CL.AddDelphiFunction('Function GetComponentUnitName( const ComponentName : string) : string');
  CL.AddDelphiFunction('Procedure GetInstalledComponents( Packages, Components : TStrings)');
  CL.AddDelphiFunction('Function GetEditControlFromEditorForm( AForm : TCustomForm) : TControl');
  CL.AddDelphiFunction('Function GetCurrentEditControl : TControl');
  CL.AddDelphiFunction('Function GetStatusBarFromEditor(EditControl: TControl) : TStatusBar');
  CL.AddDelphiFunction('Function GetCurrentSyncButton : TControl');
  CL.AddDelphiFunction('Function GetCurrentSyncButtonVisible : Boolean');
  CL.AddDelphiFunction('Function GetCodeTemplateListBox : TControl');
  CL.AddDelphiFunction('Function GetCodeTemplateListBoxVisible : Boolean');
  CL.AddDelphiFunction('Function IsCurrentEditorInSyncMode : Boolean');
  CL.AddDelphiFunction('Function IsKeyMacroRunning : Boolean');
  CL.AddDelphiFunction('Function GetCurrentCompilingProject : IOTAProject');
  CL.AddDelphiFunction('Function ConvertIDETreeNodeToTreeNode(Node: TObject) : TTreeNode');
  CL.AddDelphiFunction('Function ConvertIDETreeNodesToTreeNodes(Nodes: TObject) : TTreeNodes');
  SIRegister_TCnPaletteWrapper(CL);
  CL.AddDelphiFunction('Function CnPaletteWrapper : TCnPaletteWrapper');
{$IFDEF BDS}
  CL.AddTypeS('TXTreeView', 'TCustomControl');
{$ELSE}
  CL.AddTypeS('TXTreeView', 'TTreeView');
{$ENDIF}
  SIRegister_TCnMessageViewWrapper(CL);
  CL.AddDelphiFunction('Function CnMessageViewWrapper : TCnMessageViewWrapper');
end;

(* === run-time registration functions === *)

procedure TCnMessageViewWrapperEditMenuItem_R(Self: TCnMessageViewWrapper; var T: TMenuItem);
begin
  T := Self.EditMenuItem;
end;

procedure TCnMessageViewWrapperTabCaption_R(Self: TCnMessageViewWrapper; var T: string);
begin
  T := Self.TabCaption;
end;

procedure TCnMessageViewWrapperTabCount_R(Self: TCnMessageViewWrapper; var T: Integer);
begin
  T := Self.TabCount;
end;

procedure TCnMessageViewWrapperTabIndex_W(Self: TCnMessageViewWrapper; const T: Integer);
begin
  Self.TabIndex := T;
end;

procedure TCnMessageViewWrapperTabIndex_R(Self: TCnMessageViewWrapper; var T: Integer);
begin
  T := Self.TabIndex;
end;

procedure TCnMessageViewWrapperTabSetVisible_R(Self: TCnMessageViewWrapper; var T: Boolean);
begin
  T := Self.TabSetVisible;
end;

procedure TCnMessageViewWrapperTabSet_R(Self: TCnMessageViewWrapper; var T: TTabSet);
begin
  T := Self.TabSet;
end;

{$IFNDEF BDS}
procedure TCnMessageViewWrapperCurrentMessage_R(Self: TCnMessageViewWrapper; var T: string);
begin
  T := Self.CurrentMessage;
end;

procedure TCnMessageViewWrapperMessageCount_R(Self: TCnMessageViewWrapper; var T: Integer);
begin
  T := Self.MessageCount;
end;

procedure TCnMessageViewWrapperSelectedIndex_W(Self: TCnMessageViewWrapper; const T: Integer);
begin
  Self.SelectedIndex := T;
end;

procedure TCnMessageViewWrapperSelectedIndex_R(Self: TCnMessageViewWrapper; var T: Integer);
begin
  T := Self.SelectedIndex;
end;
{$ENDIF}

procedure TCnMessageViewWrapperTreeView_R(Self: TCnMessageViewWrapper; var T: TXTreeView);
begin
  T := Self.TreeView;
end;

procedure TCnMessageViewWrapperMessageViewForm_R(Self: TCnMessageViewWrapper; var T: TCustomForm);
begin
  T := Self.MessageViewForm;
end;

procedure TCnPaletteWrapperEnabled_W(Self: TCnPaletteWrapper; const T: Boolean);
begin
  Self.Enabled := T;
end;

procedure TCnPaletteWrapperEnabled_R(Self: TCnPaletteWrapper; var T: Boolean);
begin
  T := Self.Enabled;
end;

procedure TCnPaletteWrapperVisible_W(Self: TCnPaletteWrapper; const T: Boolean);
begin
  Self.Visible := T;
end;

procedure TCnPaletteWrapperVisible_R(Self: TCnPaletteWrapper; var T: Boolean);
begin
  T := Self.Visible;
end;

procedure TCnPaletteWrapperIsMultiLine_R(Self: TCnPaletteWrapper; var T: Boolean);
begin
  T := Self.IsMultiLine;
end;

procedure TCnPaletteWrapperTabCount_R(Self: TCnPaletteWrapper; var T: Integer);
begin
  T := Self.TabCount;
end;

procedure TCnPaletteWrapperTabs_R(Self: TCnPaletteWrapper; var T: string; const t1: Integer);
begin
  T := Self.Tabs[t1];
end;

procedure TCnPaletteWrapperTabIndex_W(Self: TCnPaletteWrapper; const T: Integer);
begin
  Self.TabIndex := T;
end;

procedure TCnPaletteWrapperTabIndex_R(Self: TCnPaletteWrapper; var T: Integer);
begin
  T := Self.TabIndex;
end;

procedure TCnPaletteWrapperActiveTab_R(Self: TCnPaletteWrapper; var T: string);
begin
  T := Self.ActiveTab;
end;

procedure TCnPaletteWrapperPalToolCount_R(Self: TCnPaletteWrapper; var T: Integer);
begin
  T := Self.PalToolCount;
end;

procedure TCnPaletteWrapperSelector_R(Self: TCnPaletteWrapper; var T: TSpeedButton);
begin
  T := Self.Selector;
end;

procedure TCnPaletteWrapperSelectedToolName_R(Self: TCnPaletteWrapper; var T: string);
begin
  T := Self.SelectedToolName;
end;

procedure TCnPaletteWrapperSelectedIndex_W(Self: TCnPaletteWrapper; const T: Integer);
begin
  Self.SelectedIndex := T;
end;

procedure TCnPaletteWrapperSelectedIndex_R(Self: TCnPaletteWrapper; var T: Integer);
begin
  T := Self.SelectedIndex;
end;

procedure RIRegister_TCnMessageViewWrapper(CL: TPSRuntimeClassImporter);
begin
  with CL.Add(TCnMessageViewWrapper) do
  begin
    RegisterConstructor(@TCnMessageViewWrapper.Create, 'Create');
    RegisterMethod(@TCnMessageViewWrapper.UpdateAllItems, 'UpdateAllItems');
    RegisterMethod(@TCnMessageViewWrapper.EditMessageSource, 'EditMessageSource');
    RegisterPropertyHelper(@TCnMessageViewWrapperMessageViewForm_R, nil, 'MessageViewForm');
    RegisterPropertyHelper(@TCnMessageViewWrapperTreeView_R, nil, 'TreeView');
{$IFNDEF BDS}
    RegisterPropertyHelper(@TCnMessageViewWrapperSelectedIndex_R, @TCnMessageViewWrapperSelectedIndex_W, 'SelectedIndex');
    RegisterPropertyHelper(@TCnMessageViewWrapperMessageCount_R, nil, 'MessageCount');
    RegisterPropertyHelper(@TCnMessageViewWrapperCurrentMessage_R, nil, 'CurrentMessage');
{$ENDIF}
    RegisterPropertyHelper(@TCnMessageViewWrapperTabSet_R, nil, 'TabSet');
    RegisterPropertyHelper(@TCnMessageViewWrapperTabSetVisible_R, nil, 'TabSetVisible');
    RegisterPropertyHelper(@TCnMessageViewWrapperTabIndex_R, @TCnMessageViewWrapperTabIndex_W, 'TabIndex');
    RegisterPropertyHelper(@TCnMessageViewWrapperTabCount_R, nil, 'TabCount');
    RegisterPropertyHelper(@TCnMessageViewWrapperTabCaption_R, nil, 'TabCaption');
    RegisterPropertyHelper(@TCnMessageViewWrapperEditMenuItem_R, nil, 'EditMenuItem');
  end;
end;

procedure RIRegister_TCnPaletteWrapper(CL: TPSRuntimeClassImporter);
begin
  with CL.Add(TCnPaletteWrapper) do
  begin
    RegisterConstructor(@TCnPaletteWrapper.Create, 'Create');
    RegisterMethod(@TCnPaletteWrapper.BeginUpdate, 'BeginUpdate');
    RegisterMethod(@TCnPaletteWrapper.EndUpdate, 'EndUpdate');
    RegisterMethod(@TCnPaletteWrapper.SelectComponent, 'SelectComponent');
    RegisterMethod(@TCnPaletteWrapper.FindTab, 'FindTab');
    RegisterPropertyHelper(@TCnPaletteWrapperSelectedIndex_R, @TCnPaletteWrapperSelectedIndex_W, 'SelectedIndex');
    RegisterPropertyHelper(@TCnPaletteWrapperSelectedToolName_R, nil, 'SelectedToolName');
    RegisterPropertyHelper(@TCnPaletteWrapperSelector_R, nil, 'Selector');
    RegisterPropertyHelper(@TCnPaletteWrapperPalToolCount_R, nil, 'PalToolCount');
    RegisterPropertyHelper(@TCnPaletteWrapperActiveTab_R, nil, 'ActiveTab');
    RegisterPropertyHelper(@TCnPaletteWrapperTabIndex_R, @TCnPaletteWrapperTabIndex_W, 'TabIndex');
    RegisterPropertyHelper(@TCnPaletteWrapperTabs_R, nil, 'Tabs');
    RegisterPropertyHelper(@TCnPaletteWrapperTabCount_R, nil, 'TabCount');
    RegisterPropertyHelper(@TCnPaletteWrapperIsMultiLine_R, nil, 'IsMultiLine');
    RegisterPropertyHelper(@TCnPaletteWrapperVisible_R, @TCnPaletteWrapperVisible_W, 'Visible');
    RegisterPropertyHelper(@TCnPaletteWrapperEnabled_R, @TCnPaletteWrapperEnabled_W, 'Enabled');
  end;
end;

procedure RIRegister_CnWizIdeUtils_Routines(S: TPSExec);
begin
  S.RegisterDelphiFunction(@IdeGetEditorSelectedLines, 'IdeGetEditorSelectedLines', cdRegister);
  S.RegisterDelphiFunction(@IdeGetEditorSelectedText, 'IdeGetEditorSelectedText', cdRegister);
  S.RegisterDelphiFunction(@IdeGetEditorSourceLines, 'IdeGetEditorSourceLines', cdRegister);
  S.RegisterDelphiFunction(@IdeSetEditorSelectedLines, 'IdeSetEditorSelectedLines', cdRegister);
  S.RegisterDelphiFunction(@IdeSetEditorSelectedText, 'IdeSetEditorSelectedText', cdRegister);
  S.RegisterDelphiFunction(@IdeSetEditorSourceLines, 'IdeSetEditorSourceLines', cdRegister);
  S.RegisterDelphiFunction(@IdeInsertTextIntoEditor, 'IdeInsertTextIntoEditor', cdRegister);
  S.RegisterDelphiFunction(@IdeEditorGetEditPos, 'IdeEditorGetEditPos', cdRegister);
  S.RegisterDelphiFunction(@IdeEditorGotoEditPos, 'IdeEditorGotoEditPos', cdRegister);
  S.RegisterDelphiFunction(@IdeGetBlockIndent, 'IdeGetBlockIndent', cdRegister);
  S.RegisterDelphiFunction(@IdeGetFormDesigner, 'IdeGetFormDesigner', cdRegister);
  S.RegisterDelphiFunction(@IdeGetDesignedForm, 'IdeGetDesignedForm', cdRegister);
  S.RegisterDelphiFunction(@IdeGetFormSelection, 'IdeGetFormSelection', cdRegister);
  S.RegisterDelphiFunction(@IdeGetSourceByFileName, 'IdeGetSourceByFileName', cdRegister);
  S.RegisterDelphiFunction(@IdeSetSourceByFileName, 'IdeSetSourceByFileName', cdRegister);
  S.RegisterDelphiFunction(@GetIdeMainForm, 'GetIdeMainForm', cdRegister);
  S.RegisterDelphiFunction(@GetIdeEdition, 'GetIdeEdition', cdRegister);
  S.RegisterDelphiFunction(@GetComponentPaletteTabControl, 'GetComponentPaletteTabControl', cdRegister);
  S.RegisterDelphiFunction(@GetNewComponentPaletteTabControl, 'GetNewComponentPaletteTabControl', cdRegister);
  S.RegisterDelphiFunction(@GetObjectInspectorForm, 'GetObjectInspectorForm', cdRegister);
  S.RegisterDelphiFunction(@GetComponentPalettePopupMenu, 'GetComponentPalettePopupMenu', cdRegister);
  S.RegisterDelphiFunction(@GetComponentPaletteControlBar, 'GetComponentPaletteControlBar', cdRegister);
  S.RegisterDelphiFunction(@GetIdeInsightBar, 'GetIdeInsightBar', cdRegister);
  S.RegisterDelphiFunction(@GetMainMenuItemHeight, 'GetMainMenuItemHeight', cdRegister);
  S.RegisterDelphiFunction(@IsIdeEditorForm, 'IsIdeEditorForm', cdRegister);
  S.RegisterDelphiFunction(@IsIdeDesignForm, 'IsIdeDesignForm', cdRegister);
  S.RegisterDelphiFunction(@BringIdeEditorFormToFront, 'BringIdeEditorFormToFront', cdRegister);
  S.RegisterDelphiFunction(@IDEIsCurrentWindow, 'IDEIsCurrentWindow', cdRegister);
  S.RegisterDelphiFunction(@GetInstallDir, 'GetInstallDir', cdRegister);
{$IFDEF BDS}
  S.RegisterDelphiFunction(@GetBDSUserDataDir, 'GetBDSUserDataDir', cdRegister);
{$ENDIF}
  S.RegisterDelphiFunction(@GetProjectLibPath, 'GetProjectLibPath', cdRegister);
  S.RegisterDelphiFunction(@GetFileNameFromModuleName, 'GetFileNameFromModuleName', cdRegister);
  S.RegisterDelphiFunction(@CnOtaGetVersionInfoKeys, 'CnOtaGetVersionInfoKeys', cdRegister);
  S.RegisterDelphiFunction(@GetLibraryPath, 'GetLibraryPath', cdRegister);
  S.RegisterDelphiFunction(@GetComponentUnitName, 'GetComponentUnitName', cdRegister);
  S.RegisterDelphiFunction(@GetInstalledComponents, 'GetInstalledComponents', cdRegister);
  S.RegisterDelphiFunction(@GetEditControlFromEditorForm, 'GetEditControlFromEditorForm', cdRegister);
  S.RegisterDelphiFunction(@GetCurrentEditControl, 'GetCurrentEditControl', cdRegister);
  S.RegisterDelphiFunction(@GetStatusBarFromEditor, 'GetStatusBarFromEditor', cdRegister);
  S.RegisterDelphiFunction(@GetCurrentSyncButton, 'GetCurrentSyncButton', cdRegister);
  S.RegisterDelphiFunction(@GetCurrentSyncButtonVisible, 'GetCurrentSyncButtonVisible', cdRegister);
  S.RegisterDelphiFunction(@GetCodeTemplateListBox, 'GetCodeTemplateListBox', cdRegister);
  S.RegisterDelphiFunction(@GetCodeTemplateListBoxVisible, 'GetCodeTemplateListBoxVisible', cdRegister);
  S.RegisterDelphiFunction(@IsCurrentEditorInSyncMode, 'IsCurrentEditorInSyncMode', cdRegister);
  S.RegisterDelphiFunction(@IsKeyMacroRunning, 'IsKeyMacroRunning', cdRegister);
  S.RegisterDelphiFunction(@GetCurrentCompilingProject, 'GetCurrentCompilingProject', cdRegister);
  S.RegisterDelphiFunction(@ConvertIDETreeNodeToTreeNode, 'ConvertIDETreeNodeToTreeNode', cdRegister);
  S.RegisterDelphiFunction(@ConvertIDETreeNodesToTreeNodes, 'ConvertIDETreeNodesToTreeNodes', cdRegister);
  S.RegisterDelphiFunction(@CnPaletteWrapper, 'CnPaletteWrapper', cdRegister);
  S.RegisterDelphiFunction(@CnMessageViewWrapper, 'CnMessageViewWrapper', cdRegister);
end;

procedure RIRegister_CnWizIdeUtils(CL: TPSRuntimeClassImporter);
begin
  RIRegister_TCnPaletteWrapper(CL);
  RIRegister_TCnMessageViewWrapper(CL);
end;

{ TPSImport_CnWizIdeUtils }

procedure TPSImport_CnWizIdeUtils.CompileImport1(CompExec: TPSScript);
begin
  SIRegister_CnWizIdeUtils(CompExec.Comp);
end;

procedure TPSImport_CnWizIdeUtils.ExecImport1(CompExec: TPSScript; const ri: TPSRuntimeClassImporter);
begin
  RIRegister_CnWizIdeUtils(ri);
  RIRegister_CnWizIdeUtils_Routines(CompExec.Exec); // comment it if no routines
end;

end.

