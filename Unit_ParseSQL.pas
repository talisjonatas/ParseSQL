{
 +--------------------------------------------------------------------------+
  ParseSQL

  Author: Talis Jonatas Gomes
  Email: talisjonatas@me.com

  This source code is provided 'as-is', without any express or implied
  warranty. In no event will the author be held liable for any damages
  arising from the use of this code.

  However, it is granted that this code may be used for any purpose,
  including commercial applications.

  If you use this software in a product, an acknowledgment in the product
  documentation would be appreciated but is not required.

  God bless you
 +--------------------------------------------------------------------------+
}

unit Unit_ParseSQL;

interface

uses
  System.Classes;

function ParseSQL(const SQLScript: string; const ADelimiter: string = 'go'): TStrings;

implementation

uses
  System.SysUtils;

function ParseSQL(const SQLScript: string; const ADelimiter: string = 'go'): TStrings;
var
  Lines: TStringList;
  LineIdx: Integer;
  Words: TStringList;
  vWordString: string;
  WordIdx, I: Integer;
  InBlock: Boolean;
  CurrentBlock: TStringBuilder;
begin
  Result := TStringList.Create;
  Lines := TStringList.Create;
  Words := TStringList.Create;
  CurrentBlock := TStringBuilder.Create;
  try
    // Quebrar o script em linhas
    Lines.Text := SQLScript;

    for LineIdx := 0 to Lines.Count - 1 do
    begin
      // Se não tiver nada na linha vai para prox
      if Trim(Lines[LineIdx]) = '' then
       continue;

      // Quebrar a linha em palavras
      Words.Clear;
      vWordString:= '';
      for I := 1 to Length(Lines[LineIdx]) do
      begin
       if vWordString <> '' then
       begin
        if ((vWordString[Length(vWordString)] = ' ') and (Lines[LineIdx][I] = ' ')) or
           ((vWordString[Length(vWordString)] <> ' ') and (Lines[LineIdx][I] <> ' ')) then
         vWordString:= vWordString + Lines[LineIdx][I]
        else
        begin
         Words.Add(vWordString);
         vWordString:= Lines[LineIdx][I];
        end;
       end else
        vWordString:= Lines[LineIdx][I];
      end;
      if vWordString <> '' then
       Words.Add(vWordString);


      for WordIdx := 0 to Words.Count - 1 do
      begin
        // Verificar se a palavra é "go"
        if Trim(Words[WordIdx]).ToUpper = UpperCase(ADelimiter) then
        begin
          // Adicionar bloco atual se houver conteúdo
          if InBlock then
          begin
            if CurrentBlock.Length > 0 then
            if Trim(CurrentBlock.ToString) <> '' then
            begin
              Result.Add(CurrentBlock.ToString);

              //Retira a ultima linha em branco se houver
              if LastDelimiter(sLineBreak, Result[Pred(Result.Count)]) = Length(Result[Pred(Result.Count)]) then
               Result[Pred(Result.Count)]:= Copy(Result[Pred(Result.Count)], 1, Length(Result[Pred(Result.Count)]) - 1);
            end;

            CurrentBlock.Clear;
          end;
          InBlock := False;
        end
        else
        begin
          CurrentBlock.Append(Words[WordIdx]);
          InBlock := True;
        end;
      end;

      // Adicionar quebra de linha ao bloco atual
      if InBlock then
       CurrentBlock.AppendLine
    end;

    // Adicionar último bloco se houver conteúdo
    if CurrentBlock.Length > 0 then
      Result.Add(CurrentBlock.ToString);
  finally
    Lines.Free;
    Words.Free;
    CurrentBlock.Free;
  end;
end;

end.
