# ParseSQL Delphi
Parse your SQL Script (MSSQL, firebird, etc)

# Author
Talis Jonatas Gomes
<br>
talisjonatas@me.com

# Usage
```delphi
var vMyParsedScript: TStrings;
vMyParsedScript:= TStringList.Create;
vMyParsedScript:= ParseSQL(MyScriptSQL, 'go'); //use Go if MSSQL

for I := 0 to Pred(vMyParsedScript.Count) do
begin
 ADOCommand1.CommandText:= vMyParsedScript[I];
 ...
end;
```

# Others Project Open Source
Delphi Web
<br>
Learn about D2Bridge Framework
<br>
https://www.d2bridge.com.br
