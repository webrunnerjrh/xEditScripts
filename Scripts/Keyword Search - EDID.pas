{
	Purpose: Keyword Search - EDID
	Game: The Elder Scrolls V: Skyrim
	Author: fireundubh <fireundubh@gmail.com>
	Version: 0.1
}

unit UserScript;

var
	slResults: TStringList;
	sQuery: string;

function Initialize: integer;
	begin

		Result := 0;

		ClearMessages();
		
		slResults := TStringList.Create;
		slResults.Sorted := True;
		slResults.Duplicates := dupIgnore;
		
		if not InputQuery('Enter', 'Search Query:', sQuery) then begin
			Result := 1;
			exit;
		end; // end if
		
		if sQuery = '' then begin
			Result := 1;
			exit;
		end; // end if

		AddMessage('-------------------------------------------------------------------------------');
		
	end; // end begin

function Process(e: IInterface): integer;
	var
		sFormID, sName: string;

	begin
		
		Result := 0;

		sFormID := IntToHex(FixedFormID(e),8);
		sName := GetEditValue(ElementByPath(e, 'EDID'));
			
		if pos(lowercase(sQuery), lowercase(sName)) > 0 then begin
			slResults.Add('[' + Signature(e) + ':' + sFormID + '] ' + sName );
		end;

	end;

function Finalize: integer;
	var
		i: integer;
	begin
	
		slResults.Sort();
		
		for i := 0 to slResults.Count - 1 do begin
		
			AddMessage(slResults[i]);
		
		end;
		
		slResults.Clear;
	
		AddMessage('-------------------------------------------------------------------------------');
		Result := 1;
		
	end;

end.
