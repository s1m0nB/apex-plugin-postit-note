function addPostItNoteRegion (  p_region              in apex_plugin.t_region
                             ,  p_plugin              in apex_plugin.t_plugin
                             ,  p_is_printer_friendly in boolean )
return apex_plugin.t_region_render_result
is
    -- plugin attributes
    l_note_text   varchar2(32676)  := p_region.attribute_01;
    l_note_date   varchar2(32676)  := p_region.attribute_02;
    l_note_sql    varchar2(32676)  := p_region.attribute_03;
    -- sql result variable
    l_sql_list    apex_plugin_util.t_column_value_list;
    -- dummy result
    l_result      apex_plugin.t_region_render_result;
begin
    -- detrmine data based on sql attribute
    if l_note_text is null
    and l_note_sql is not null
    then
        l_sql_list := apex_plugin_util.get_data ( p_sql_statement  => l_note_sql
                                                , p_min_columns    => 1
                                                , p_max_columns    => 2
                                                , p_component_name => p_region.name );
        -- loop thruresult
        for i in 1 .. l_sql_list(1).count
        loop
            l_note_text := sys.htf.escape_sc(l_sql_list(1)(i));
            l_note_date := sys.htf.escape_sc(l_sql_list(2)(i));
        end loop;
    end if;
    -- render the html
    htp.prn('<div class="apex-postit-container">');
    htp.prn('<i class="apex-postit-pin"></i>');
    htp.prn('<blockquote class="apex-postit-note apex-postit-yellow">'||l_note_text||'<cite class="apex-postit-date">'||l_note_date||'</cite></blockquote>');
    htp.prn('</div>'); 
    return l_result;
    --
end addPostItNoteRegion;
