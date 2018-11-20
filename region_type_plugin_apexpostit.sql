prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- ORACLE Application Express (APEX) export file
--
-- You should run the script connected to SQL*Plus as the Oracle user
-- APEX_180200 or as the owner (parsing schema) of the application.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_api.import_begin (
 p_version_yyyy_mm_dd=>'2018.05.24'
,p_release=>'18.2.0.00.12'
,p_default_workspace_id=>12391180323004392729
,p_default_application_id=>35723
,p_default_owner=>'SB_DEV'
);
end;
/
prompt --application/shared_components/plugins/region_type/apexpostit
begin
wwv_flow_api.create_plugin(
 p_id=>wwv_flow_api.id(11130142754716538353)
,p_plugin_type=>'REGION TYPE'
,p_name=>'APEXPOSTIT'
,p_display_name=>'PostItNote'
,p_supported_ui_types=>'DESKTOP'
,p_css_file_urls=>'#PLUGIN_FILES#apex-postit.css'
,p_plsql_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'function addPostItNoteRegion (  p_region              in apex_plugin.t_region',
'                             ,  p_plugin              in apex_plugin.t_plugin',
'                             ,  p_is_printer_friendly in boolean )',
'return apex_plugin.t_region_render_result',
'is',
'    -- plugin attributes',
'    l_note_text   varchar2(32676)  := p_region.attribute_01;',
'    l_note_date   varchar2(32676)  := p_region.attribute_02;',
'    l_note_sql    varchar2(32676)  := p_region.attribute_03;',
'    -- sql result variable',
'    l_sql_list    apex_plugin_util.t_column_value_list;',
'    -- dummy result',
'    l_result      apex_plugin.t_region_render_result;',
'begin',
'    -- detrmine data based on sql attribute',
'    if l_note_text is null',
'    and l_note_sql is not null',
'    then',
'        l_sql_list := apex_plugin_util.get_data ( p_sql_statement  => l_note_sql',
'                                                , p_min_columns    => 1',
'                                                , p_max_columns    => 2',
'                                                , p_component_name => p_region.name );',
'        -- loop thruresult',
'        for i in 1 .. l_sql_list(1).count',
'        loop',
'            l_note_text := l_sql_list(1)(i);',
'            l_note_date := l_sql_list(2)(i);',
'        end loop;',
'    end if;',
'    -- escape output if set',
'    if p_region.escape_output',
'    then',
'        l_note_text := sys.htf.escape_sc(l_note_text);',
'        l_note_date := sys.htf.escape_sc(l_note_date);',
'    end if;',
'    -- render the html',
'    htp.prn(''<div class="apex-postit-container">'');',
'    htp.prn(''<i class="apex-postit-pin"></i>'');',
'    htp.prn(''<blockquote class="apex-postit-note apex-postit-yellow">''||l_note_text||''<cite class="apex-postit-date">''||l_note_date||''</cite></blockquote>'');',
'    htp.prn(''</div>''); ',
'    return l_result;',
'    --',
'end addPostItNoteRegion;'))
,p_api_version=>2
,p_render_function=>'addPostItNoteRegion'
,p_standard_attributes=>'ESCAPE_OUTPUT'
,p_substitute_attributes=>true
,p_subscribe_plugin_settings=>true
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'This region plugin has 3 (optional) attributes defined;',
'  note-text - for static text assignment to the note (can include html)',
'  note-date - displayed in right bottom of note, can also contain author or other information to highlight.',
'  note-sql  - instead of static text, provide a sql statement for these to attributes (can''t contain html)'))
,p_version_identifier=>'1.0'
,p_about_url=>'https://github.com/s1m0nB/apex-plugin-postit-note'
,p_files_version=>8
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(11136978764211734740)
,p_plugin_id=>wwv_flow_api.id(11130142754716538353)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_prompt=>'note-text'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_supported_ui_types=>'DESKTOP'
,p_is_translatable=>false
,p_help_text=>'Use this attribute to set a static text for your note'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(11145592999972767650)
,p_plugin_id=>wwv_flow_api.id(11130142754716538353)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_prompt=>'note-date'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_is_translatable=>false
,p_help_text=>'Use this text-attribute to be displayed in the note''s bottom right corner, highlighted'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(11156832982335855825)
,p_plugin_id=>wwv_flow_api.id(11130142754716538353)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>3
,p_display_sequence=>30
,p_prompt=>'note-sql'
,p_attribute_type=>'SQL'
,p_is_required=>false
,p_sql_min_column_count=>1
,p_sql_max_column_count=>2
,p_is_translatable=>false
,p_examples=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ''Here you can put the text''      note_text',
'     , to_char(sysdate,''dd month yyyy'') note_date',
'  from dual'))
,p_help_text=>'This attribute holds the sql statement for the data to be displayed in the post-it note. The SQL Statement can hold up to 2 columns for the note''s text and the dat of the note. Check below example for the format of the sql query.'
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '2E617065782D706F737469742D6E6F7465207B0D0A2020636F6C6F723A20233333333B0D0A2020706F736974696F6E3A2072656C61746976653B0D0A202077696474683A203830253B0D0A20206D617267696E2D746F703A20333070783B0D0A20207061';
wwv_flow_api.g_varchar2_table(2) := '6464696E673A20313070783B0D0A2020666F6E742D66616D696C793A202748656C766574696361204E657565272C275365676F65205549272C48656C7665746963612C417269616C2C73616E732D73657269663B0D0A2020666F6E742D73697A653A2031';
wwv_flow_api.g_varchar2_table(3) := '3470783B0D0A2020626F782D736861646F773A20302031307078203130707820327078207267626128302C302C302C302E33293B0D0A7D0D0A0D0A2E617065782D706F737469742D6E6F7465202E617065782D706F737469742D64617465207B0D0A2020';
wwv_flow_api.g_varchar2_table(4) := '646973706C61793A20626C6F636B3B0D0A20206D617267696E3A20333070782030203020303B0D0A2020746578742D616C69676E3A2072696768743B0D0A2020666F6E742D73697A653A20313270783B0D0A2020666F6E742D7765696768743A20626F6C';
wwv_flow_api.g_varchar2_table(5) := '643B200D0A7D0D0A2E617065782D706F737469742D79656C6C6F77207B0D0A20206261636B67726F756E643A20236561653637323B0D0A20202D7765626B69742D7472616E73666F726D3A20726F746174652832646567293B0D0A20202D6D6F7A2D7472';
wwv_flow_api.g_varchar2_table(6) := '616E73666F726D3A20726F746174652832646567293B0D0A20202D6F2D7472616E73666F726D3A20726F746174652832646567293B0D0A20202D6D732D7472616E73666F726D3A20726F746174652832646567293B0D0A20207472616E73666F726D3A20';
wwv_flow_api.g_varchar2_table(7) := '726F746174652832646567293B0D0A7D0D0A2E617065782D706F737469742D70696E207B0D0A20206261636B67726F756E642D636F6C6F723A20236161613B0D0A2020646973706C61793A20626C6F636B3B0D0A20206865696768743A20333270783B0D';
wwv_flow_api.g_varchar2_table(8) := '0A202077696474683A203270783B0D0A2020706F736974696F6E3A206162736F6C7574653B0D0A20206C6566743A203530253B0D0A2020746F703A20313070783B0D0A20207A2D696E6465783A20313B0D0A7D0D0A2E617065782D706F737469742D7069';
wwv_flow_api.g_varchar2_table(9) := '6E3A6166746572207B0D0A20206261636B67726F756E642D636F6C6F723A20234133313B0D0A20206261636B67726F756E642D696D6167653A2072616469616C2D6772616469656E7428323525203235252C20636972636C652C2068736C6128302C3025';
wwv_flow_api.g_varchar2_table(10) := '2C313030252C2E33292C2068736C6128302C30252C30252C2E3329293B0D0A2020626F726465722D7261646975733A203530253B0D0A2020626F782D736861646F773A20696E736574203020302030203170782068736C6128302C30252C30252C2E3129';
wwv_flow_api.g_varchar2_table(11) := '2C0D0A2020202020202020202020202020696E7365742033707820337078203370782068736C6128302C30252C313030252C2E32292C0D0A2020202020202020202020202020696E736574202D337078202D337078203370782068736C6128302C30252C';
wwv_flow_api.g_varchar2_table(12) := '30252C2E32292C0D0A2020202020202020202020202020323370782032307078203370782068736C6128302C30252C30252C2E3135293B0D0A2020636F6E74656E743A2027273B0D0A20206865696768743A20313270783B0D0A20206C6566743A202D35';
wwv_flow_api.g_varchar2_table(13) := '70783B0D0A2020706F736974696F6E3A206162736F6C7574653B0D0A2020746F703A202D313070783B0D0A202077696474683A20313270783B0D0A7D0D0A2E617065782D706F737469742D70696E3A6265666F7265207B0D0A20206261636B67726F756E';
wwv_flow_api.g_varchar2_table(14) := '642D636F6C6F723A2068736C6128302C30252C30252C302E31293B0D0A2020626F782D736861646F773A20302030202E3235656D2068736C6128302C30252C30252C2E31293B0D0A2020636F6E74656E743A2027273B0D0A0D0A20206865696768743A20';
wwv_flow_api.g_varchar2_table(15) := '323470783B0D0A202077696474683A203270783B0D0A20206C6566743A20303B0D0A2020706F736974696F6E3A206162736F6C7574653B0D0A2020746F703A203870783B0D0A0D0A20207472616E73666F726D3A20726F746174652835372E3564656729';
wwv_flow_api.g_varchar2_table(16) := '3B0D0A20202D6D6F7A2D7472616E73666F726D3A20726F746174652835372E35646567293B0D0A20202D7765626B69742D7472616E73666F726D3A20726F746174652835372E35646567293B0D0A20202D6F2D7472616E73666F726D3A20726F74617465';
wwv_flow_api.g_varchar2_table(17) := '2835372E35646567293B0D0A20202D6D732D7472616E73666F726D3A20726F746174652835372E35646567293B0D0A0D0A20207472616E73666F726D2D6F726967696E3A2035302520313030253B0D0A20202D6D6F7A2D7472616E73666F726D2D6F7269';
wwv_flow_api.g_varchar2_table(18) := '67696E3A2035302520313030253B0D0A20202D7765626B69742D7472616E73666F726D2D6F726967696E3A2035302520313030253B0D0A20202D6D732D7472616E73666F726D2D6F726967696E3A2035302520313030253B0D0A20202D6F2D7472616E73';
wwv_flow_api.g_varchar2_table(19) := '666F726D2D6F726967696E3A2035302520313030253B0D0A7D';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(11131073098529593588)
,p_plugin_id=>wwv_flow_api.id(11130142754716538353)
,p_file_name=>'apex-postit.css'
,p_mime_type=>'text/css'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false), p_is_component_import => true);
commit;
end;
/
set verify on feedback on define on
prompt  ...done
