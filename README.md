# ParseSQL
Parse your SQL Script (MSSQL, firebird, etc)

# Author
Talis Jonatas Gomes
talisjonatas@me.com

# Usage
var vMyParsedScript: TStrings;
vMyParsedScript:= TStringList.Create;
vMyParsedScript:= ParseSQL(MyScriptSQL, 'go'); //use Go if MSSQL

for I := 0 to Pred(vMyParsedScript.Count) do
begin
 ADOCommand1.CommandText:= vMyParsedScript[Z];
 ...
end;

# Others Project Open Source
Delphi Web
Learn about D2Bridge Framework
https://www.d2bridge.com.br
