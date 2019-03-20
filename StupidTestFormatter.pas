{$coperators on}
{$mode objfpc}
{$H+}
uses SysUtils,windows,crt;
var
        path    : string;
        nam     : string;
        resPath : string;
        exINP,exOUT: string;
function ToString(x:longint):string;
var     s:ansistring;
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
procedure Solve();
var     Info    : TSearchRec;
        s       : string;
        nxt     : string;
        nani    : boolean;
begin
        if (FindFirst(path+'*'+exINP,faAnyFile,Info)=0) then begin
                repeat
                        s:=Info.Name;
                        delete(s,length(s)-length(exINP)+1,length(exINP));
                        nxt:=resPath+'TEST_'+s+'\';
                        if not check(nxt) then break;
                        writeln('coping ',path+s+exINP, ' to ',nxt+nam+'.INP');
                        if (not windows.copyfile(Pchar(path+s+exINP),Pchar(nxt+nam+'.INP'),nani)) then
                                writeln('loi');

                        writeln('coping ',path+s+exOUT, ' to ',nxt+nam+'.OUT');
                        if (not windows.copyfile(Pchar(path+s+exOUT),Pchar(nxt+nam+'.OUT'),nani)) then
                                writeln('loi');
                until FindNext(Info)<>0;
        end;
        sysutils.FindClose(Info);
        writeln('done');
end;
begin
        clrscr;
        writeln('Stupid ''Test Formatter'' by Canoccancap');
        write('Nhap duong dan toi folder test can chuyen: ');
        readln(path);
        if (path[length(path)]<>'\') then path+='\';
        write('Nhap ten bai: ');
        readln(nam);
        resPath:=path;
        writeln('Cac test moi duoc tao se nam trong: ',resPath);
        if not check(ResPath) then begin
                readln;
                exit;
        end;
        write('Nhap extention cua input (INP, IN hay gi do) : ');
        readln(exINP);
        if (exINP[1]<>'.') then exINP:='.'+exINP;
        write('Nhap extention cua answer: ');
        readln(exOUT);
        if (exOUT[1]<>'.') then exOUT:='.'+exOUT;
        //writeln('input la: ',path+nam+'\'+exinp);
        Solve();
        readln;
end.

