{$coperators on}
{$mode objfpc}
{$H+}
uses SysUtils,windows,CustApp;
const
        BUG='sugoichottomatte';
type    TArr=array of string;
var
        exINP : TArr;
        exOUT : TArr;
        path    : string;
        nam     : string;
        resPath : string;
        App: TCustomApplication;
procedure init;
begin
        exINP:=TArr.Create('inp','in');
        exOUT:=TArr.Create('out','ans','ok','output','a');
end;
function param(s:string):string;
begin
        exit(App.GetOptionValue(s));
end;
function ToString(x:longint):string;
begin
        result:=IntToStr(x);
        while (length(result)<3) do result:='0'+result;
end;
function check(s:string):boolean;
begin
        if not DirectoryExists(s) then
                if not CreateDir(s) then begin
                        writeln('Co loi xay ra trong qua trinh tao thu muc ',s);
                        exit(false);
                end;
        exit(true);
end;
function inside(var x:TArr; s:string):boolean;
var     i:longint;
begin
        for i:=0 to high(x) do
                if (s=x[i]) then exit(true);
        exit(false);
end;
function checkIn(s:string):boolean;
begin
        delete(s,1,1);
        if (App.HasOption('exI')) and (s=param('exI')) then exit(true);
        exit(inside(exINP,s));
end;
function CheckOut(s:string):boolean;
begin
        delete(s,1,1);
        if (App.HasOption('exO')) and (s=param('exO')) then exit(true);
        exit(inside(exOUT,s));
end;
function GetEx(s:string):string;
var     i:longint;
begin
        for i:=length(s) downto 1 do
                if s[i]='.' then
                        exit(copy(s,i,length(s)-i+1));
        exit(BUG);
end;
procedure Solve();
var     Info    : TSearchRec;
        s       : string;
        ex      : string;
        nxt     : string;
        nani    : boolean;
begin
        if (FindFirst(path+'*.*',faAnyFile,Info)=0) then begin
                repeat
                        s:=Info.Name;
                        ex:=GetEx(s);
                        if (ex=BUG) then continue;
                        delete(s,length(s)-length(ex)+1,length(ex));
                        nxt:=resPath+'TEST_'+s+'\';
                        if (CheckIn(ex)) then begin
                                if not check(nxt) then break;
                                if (windows.copyfile(Pchar(path+s+ex),Pchar(nxt+nam+'.INP'),nani)) then
                                        writeln('copied '+path+s+ex+' to ' + nxt+nam+'.INP')
                                else    writeln('error '+path+s+ex+' to ' + nxt+nam+'.INP');
                        end
                        else if (CheckOut(ex)) then begin
                                if not check(nxt) then break;
                                if (windows.copyfile(Pchar(path+s+ex),Pchar(nxt+nam+'.OUT'),nani)) then
                                        writeln('copied '+path+s+ex+' to ' + nxt+nam+'.OUT')
                                else    writeln('error '+path+s+ex+' to ' + nxt+nam+'.OUT');
                        end;
                until FindNext(Info)<>0;
        end;
        sysutils.FindClose(Info);
        writeln('done');
end;
begin
        App:=TCustomApplication.create(nil);
        writeln('Stupid ''Test Formatter'' by Canoccancap');
        Init;
        //Get Path of test
        if (App.HasOption('i')) then begin
                assign(input,param('i')); 
                reset(input);
        end
        else if (not App.HasOption('l')) then
                write('Nhap duong dan toi folder test can chuyen: ');
        if (App.HasOption('l')) then 
                path:=param('l')
        else 
                readln(path);
        if (path[length(path)]<>'\') then path+='\';

        // Get name of problem
        if (not App.HasOption('i') and not App.HasOption('n')) then 
                write('Nhap ten bai: ');
        if (App.HasOption('n')) then 
                nam:=param('n')
        else 
                readln(nam);
        resPath:=path;
        nam:=upcase(nam);
        writeln(nam);
        writeln('Cac test moi duoc tao se nam trong: ',resPath);
        // For Log
        if (App.HasOption('o')) then begin
                assign(output,param('o')); 
                rewrite(output);
        end;

        //
        if not check(ResPath) then begin
                exit;
        end;
        Solve();
end.
