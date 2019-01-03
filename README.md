[![APEX Plugin](https://cdn.rawgit.com/Dani3lSun/apex-github-badges/b7e95341/badges/apex-plugin-badge.svg)](<LINK>)
APEX PlugIn: SBA.APEX.POSTIT
============================

This plugin is a region plugin for use in Oracle Application Express. The PostIt Note region plugIn will show a note in the style of a post-it or sticky note. It allows to display static text or text from a query in a pre defined format, for viewing in a post-it styled note on the page. It is created using a custom cascading style sheet for styling the region like a post-it note and is inspired by a blogpost of Creative Punch; http://creative-punch.net/2014/02/create-css3-post-it-note/

## usage
Download the latest PlugIn SQL File from this repository and import it in your APEX application.

The region plugin has 3 (optional) attributes defined;
 * note-text - for static text assignement to the note 
 * note-date - displayed in right bottom of note, can also contain author or other information to highlight.
 * note-sql  - instead of static text, provide a sql statement for these two attributes 

The plug-in also utilizes the 'Escape special characters' security attribute.

## reference

https://apex.oracle.com/pls/apex/f?p=35723:20

https://eocoe.blogspot.com/2019/01/a-post-it-note-region-plugin-for-apex.html

http://creative-punch.net/2014/02/create-css3-post-it-note/

