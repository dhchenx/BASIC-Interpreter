unit Basic;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,math, XPMan, ComCtrls, Menus;

type
  TForm43 = class(TForm)
    RichEdit1: TRichEdit;
    XPManifest1: TXPManifest;
    Label1: TLabel;
    MainMenu1: TMainMenu;
    FileF1: TMenuItem;
    NewN1: TMenuItem;
    OpenO1: TMenuItem;
    SaveS1: TMenuItem;
    N1: TMenuItem;
    ExitE1: TMenuItem;
    EditE1: TMenuItem;
    Undo1: TMenuItem;
    RedoR1: TMenuItem;
    N2: TMenuItem;
    AllClearC1: TMenuItem;
    Debug1: TMenuItem;
    RunR1: TMenuItem;
    CompileToBasic1: TMenuItem;
    HelpH1: TMenuItem;
    AboutA1: TMenuItem;
    Memo1: TMemo;
    Button1: TButton;
    Memo2: TMemo;
    Button2: TButton;
    procedure Button2Click(Sender: TObject);
    procedure RunR1Click(Sender: TObject);
    procedure RichEdit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure RichEdit1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form43: TForm43;

implementation

{$R *.dfm}
var pa:Integer;
type node=^list;
list=record
    iden,ttype,value:string; {链表--变量表}
    next:node;
    end;
var head:node;
procedure write(s:string);
begin
     form43.Memo1.Text:=form43.Memo1.Text+s;
end;
procedure writeln(s:string);
begin
      form43.Memo1.Lines.Add(s)
end;
function fen(s:string):string;forward;
procedure create();  {变量表的创建}
var q:node;
begin
    new(head);
    head.value:='NULL';
    head.ttype:='NULL';
    head.iden:='Global';
    head.next:=nil;
end;
procedure add(id,t,v:string);
var p,q,h:node;          {添加变量}
var b:boolean;
begin
     q:=head;
     b:=false;
     while(q^.next<>nil)do begin
         q:=q^.next;
         if (q.iden=id) then begin
          q.value:=v;
          b:=true;
          break;
          end;
     end;
     if (b=false) then begin
     new(p);
     p.iden:=id;
     p.ttype:=t;
     p.value:=v;
     q.next:=p;
     q:=p;
     q.next:=nil;
     end;
end;
function getv(id:string):string;
var q:node;
begin
      result:=id;
      q:=head^.next;
      repeat
      if (q.iden=id) then
      begin
      result:=q.value ;
      break;
      end;
      q:=q^.next;
      until(q=nil);
end;
{运算器}
function fen(s:string):string;   {总函数}
var i,j,p:integer;
var t:string;
var rr:string;
function tocalc(s:string):string;  {计算单个括号的算式}
var m:array[1..100]of string;
var i,j,k:integer;
var token,tok:set of char;
var n,p:integer;
var temp:string;
var ch:char;
function calc(m:string;f:char;n:string):string;  {计算双目运算}
var a,b,r:extended;
var rr:string;
begin
     r:=0;
     rr:='Null';
     m:=trim(m);n:=trim(n);
     m:=getv(m);n:=getv(n);
     if (m[1]='M') then m[1]:='-';
     if (n[1]='M') then n[1]:='-';
     a:=strtofloat(m);
     b:=strtofloat(n);
     case(f) of
     '+':r:=a+b;
     '-':r:=a-b;
     '*':r:=a*b;
     '/':r:=a/b;
     '%':r:=round(a) mod round(b);
     '\':r:=round(a) div round(b);
     '<':r:=round(a) shl round(b);
     '>':r:=round(a) shr round(b);
     '^':r:=power(a,b);
     else showmessage('不支持的运算符,返回0!')
     end;
         rr:=floattostr(r);
         if (rr[1]='-') then rr[1]:='M';
         result:=rr;
end;
procedure ln(); {计算单级运算的}
var i,j:integer;
var t1,t2:string;
var ch:char;
begin
     i:=1;
     while(i<k) do begin
        ch:=m[i][1];
        if(ch in tok) then begin
            t1:=calc(m[i-1],m[i][1],m[i+1]);
            m[i-1]:=t1;
              for j:=i to k-2 do begin
                  m[j]:=m[j+2];
              end;
              k:=k-2;
        end else i:=i+1;
     end;
end;
begin
    {把每一个数字和符号分离并储存在一位数组里}
     n:=length(s);
     k:=1;
     token:=['+','-','*','/','%','\','<','>','^'];
     temp:='';
     for i:=1  to n do begin
     ch:=s[i];
         if (ch in token) then
         begin
             m[k]:=temp;
             k:=k+1;
             m[k]:=s[i];
             k:=k+1;
             temp:='';
         end
         else temp:=temp+s[i];
     end;
     m[k]:=temp;
     /// //结束//
     {计算每一级的所有运算}
      tok:=['^'];
      ln();
      tok:=['*','/','%','\','<','>'];
      ln();
      tok:=['+','-'];
      ln();
      result:=m[1];
      {结束} ///
end;
function find(s:string):integer;
var i,j:integer;
begin
    for i:=1 to length(s) do
    if s[i]=')'  then
    begin result:=i ;break end
    else if i=length(s) then result:=0;
end;
{正式函数 fem}
begin
s:=trim(s);
s:='('+s +')';
repeat
    p:=find(s);
    t:='';
if p<>0 then
begin
    for i:=p-1 downto 1 do
    begin
    if s[i]='(' then
    begin
     rr:=tocalc(t);
     s:=stringreplace(s,'('+t+')',rr,[rfreplaceall]);
     break;       //核心：替换字符
    end;
    t:=s[i]+t ;
    end ;
end
until p=0;
if (s[i]='M') then s[1]:='-';
  result:=s;
end;

function tf(s:string):boolean;
var a,b:string;      {计算布尔值}
var a1,b1:extended;
var i,j,n:integer;
var m,fu:string;
begin
    i:=0;
    a:='';b:='';
    n:=length(s);
    repeat
        i:=i+1;
        m:=s[i]+s[i+1];
        if (m='<<')or(m='<=')or(m='>=')or(m='==')or(m='!=')or(m='>>') then begin
            fu:=m;
            for j:=i+2 to n do b:=b+s[j];break;
        end;
        a:=a+s[i];
    until (i=n-1);
    {判断其大小}

    a1:=strtofloat(getv(fen(a)));
    if (b='')and(a1>0) then begin result:=true;exit; end;
    if (b='')and(a1<=0) then begin result:=false;exit;end;
    b1:=strtofloat(getv(fen(b)));

    if (fu='<<') then begin
        if (a1<b1)then result:=true else result:=false;
    end else if (fu='>>') then begin
         if (a1>b1) then result:=true else result:=false;
    end else if (fu='==') then begin
        if (a1=b1) then result:=true else result:=false;
    end else if (fu='>=') then begin
        if (a1>=b1) then result:=true else result:=false;
    end else if (fu='<=') then begin
        if (a1<=b1) then result:=true else result:=false;
    end else if (fu='!=') then begin
        if (a1<>b1) then result:=true else result:=false;
    end else result:=false;
end;
function hang(s:string;n:integer):integer;
var i,count:integer;
begin
      count:=0;
      for i:=1 to n do
        if (s[i]=chr(13)) then count:=count+1;
        result:=count;
end;
var pro:array of string;
procedure tran();
  procedure dec(s:string); {声明}
  var i,j,k:integer;
  var id,t,v:string;
  begin
      id:='';t:='';v:='';
      for i:=1 to length(s) do
       if (s[i]=' ') then break else t:=t+s[i];
       for j:=i+1 to length(s) do
        if (s[j]='=') then break else id:=id+s[j];
        for k:=j+1 to length(s) do
         if (s[k]=' ') then break else v:=v+s[k];
        add(id,t,v);
  end;
  procedure ln(s:string);
  var a,b:string;
  var i,j:integer;
  begin
     b:='';a:='';
     for i:=1 to length(s) do
       if (s[i]='=') then break
       else a:=a+s[i];
         for j:=i+1 to length(s) do
            b:=b+s[j];
       add(a,'Object',fen(b));
  end;
  procedure jump(m,s:string);
  var i,j,k,n:integer;
  var a,b,c:string;
  var cc:boolean;
  begin
      n:=length(s);
      a:='';b:='';
     for i:=1 to n do
       if (s[i]=' ')then break;

     for j:=i+1 to n do
       if (s[j]=' ')then  break
       else a:=a+s[j];


       for k:=j+1 to n do
        b:=b+s[k];

        trim(a);
        trim(b);
       if (m='iffalse') then begin
           cc:=tf(a);
           if(cc=false) then pa:=strtoint(b)
           else pa:=pa+1;
       end
       else
       if (tf(a)=true) then begin
        pa:=strtoint(b);
        end else pa:=pa+1;

  end;

  procedure typeof(s:string);
  var m:string;
  var hh:string;
  var i,j:integer;
   function checkm(s:string;var a:string;var b:string):boolean;
   var i,j,k:integer;
   var p:boolean;
   begin
         a:='';b:='';
         p:=false;
         result:=false;
         for i:=1 to length(s) do
           if (s[i]=':')then begin
               p:=true;break;
           end else a:=a+s[i];
         if (p=true) then begin
             for j:=i+1 to length(s) do
               b:=b+s[j];
               result:=true;
         end;

   end;
  var a,b:string;
  var mm:boolean;
  begin
     m:='';
     s:=trim(s);
     mm:=checkm(s,a,b);
     if (mm=true) then begin
         typeof(a);
         typeof(b);
         exit;
     end;
     if (s='')or(s='endif')or(s='ifelse')or(s='next')or(s='do') then begin pa:=pa+1;exit; end;

     for i:=1 to length(s) do
       if (s[i]=' ') then break
       else m:=m+s[i];

       if (m='int')or(m='float')or(m='char') then
       begin  dec(s);pa:=pa+1;end
         else
       if (m='iffalse')or(m='if') then
       jump(m,s)
       else
         if (m='goto') then  begin
         m:='';
         for j:=i+1 to length(s) do
            m:=m+s[j];
         pa:=strtoint(m) ;
         end
         else if (m='exit') then begin pa:=length(pro);end
         else if (m='print') then begin
         hh:='';
               for i:=7 to length(s)do
                    hh:=hh+s[i];
               hh:=getv(fen(hh));
               write(hh);
               pa:=pa+1;
         end else if(m='println') then begin
                hh:='';
               for i:=9 to length(s)do
                    hh:=hh+s[i];
               hh:=getv(fen(hh));
               writeln(hh);
               pa:=pa+1;
         end else
         begin ln(s);pa:=pa+1;end;//todoit
  end;
  var i,j,k,n:integer;
  var q:node;
  var s:string;
begin
    create();
    n:=length(pro)-1;
    pa:=0;
     repeat
       typeof(pro[pa]);
     until (pa>n);
end;
{高级语法解释}
procedure gett(m:trichedit);
var i,j:integer;
begin
    setlength(pro,m.Lines.Count);
    for i:=0 to length(pro)-1 do
    begin
        pro[i]:=m.Lines.Strings[i];
    end;
end;
procedure tr_if();
 function getco(s:string):string;
 var i,j:integer;
 var r:string;
 begin
       r:='';
      for i:=1 to length(s) do
       if (s[i]=' ') then break;
      for j:=i+1 to length(s) do
      if (s[j]=' ') then break
      else r:=r+s[j];
      result:=r;
 end;
 function getif(s:string):string;
 var i:integer;
 var r:string;
 var r1:string;
 begin
     r:='';
     r1:='';
     if (length(s)>=7) then begin
     for i:=1 to 3 do  r:=r+s[i];
     for i:=length(s)-3 to length(s) do
        r1:=r1+s[i];
     end;
     result:=r+r1;
 end;
 function checkelse(i,j:integer):integer;
 var k:integer;
 var r:integer;
 begin
      r:=-1;
      for k:=i+1 to j-1 do begin
          if(pro[k]='else') then  begin
              r:=k;
              break;
          end;
      end;
      result:=k;
 end;
 var i,j,k:integer;
var co:string;
var n,last:integer;
var b,c:boolean;
begin
     n:=length(pro)-1;
     b:=false;
     c:=false;
     repeat
      for i:=0 to n do  begin
          if (pro[i]='end if') then
           for j:=i downto 0 do begin
             if (getif(pro[j])='if then')then begin
             last:=i+1;
              if (checkelse(j,i)<>-1) then
              begin
              last:=checkelse(j,i);
               pro[last]:='ifelse';
              end;
                 pro[j]:='iffalse '+getco(pro[j])+ ' '+inttostr(last);
                 pro[i]:='endif';
                 b:=true;
                 break;
             end;
             if (b=true) then break;
          end;
            if (b=true) then break;
      end;
         if (i=n)then c:=true;
         if (b=false) then c:=true;
         b:=false;
     until(c=true);
end;
procedure tr_while();
 function getco(s:string):string;
 var i,j:integer;
 var co:string;
 begin
     s:=trim(s);
     co:='';
     if (length(s)>=7) then
     begin
         for i:=1 to length(s) do
           if (s[i]=' ') then break;
         for j:=i+1 to length(s) do
           co:=co+s[j];
     end;
     result:=co;
 end;
 function getw(s:string):string;
 var i:integer;
 var r:string;
 begin
     r:='';
     if (length(s)>=7) then
     for i:=1 to 6 do
      r:=r+s[i];
      result:=r;
 end;
 function checkbreak(i,j:integer):integer;
 var r:integer;
 var k:integer;
 begin
      r:=-1;
      for k:=i+1 to j-1 do
      if (pro[k]='break') then r:=k;
      result:=r;
 end;
 var i,j,k:integer;
var co:string;
var n,last:integer;
var b,c:boolean;
begin
         n:=length(pro)-1;
     b:=false;
     c:=false;
     repeat
      for i:=0 to n do  begin
          if (pro[i]='end while') then
           for j:=i downto 0 do begin
             if (getw(pro[j])='while ')then begin
                 last:=i+1;
                 if (checkbreak(j,i)<>-1) then
                 begin
                     pro[checkbreak(j,i)]:='goto '+inttostr(last);
                 end;
                 pro[j]:='iffalse '+getco(pro[j])+ ' '+inttostr(last);
                 pro[i]:='goto '+inttostr(j);
                 b:=true;
                 break;
             end;
             if (b=true) then break;
          end;
            if (b=true) then break;
      end;
         if (i=n)then c:=true;
         if (b=false) then c:=true;
         b:=false;
     until(c=true);
end;
procedure tr_do();
function getco(s:string):string;
 var i,j:integer;
 var co:string;
 begin
     s:=trim(s);
     co:='';
     if (length(s)>=6) then
     begin
         for i:=1 to length(s) do
           if (s[i]=' ') then break;
         for j:=i+1 to length(s) do
           co:=co+s[j];
     end;
     result:=co;
 end;
function getl(s:string):string;
 var i:integer;
 var r:string;
 begin
     r:='';
     if (length(s)>=7) then
     for i:=1 to 4 do
      r:=r+s[i];
      result:=r;
 end;
 function checkbreak(i,j:integer):integer;
 var r:integer;
 var k:integer;
 begin
      r:=-1;
      for k:=i+1 to j-1 do
      if (pro[k]='break') then r:=k;
      result:=r;
 end;
 var i,j,k:integer;
var co:string;
var n,last:integer;
var b,c:boolean;
begin
         n:=length(pro)-1;
     b:=false;
     c:=false;
     repeat
      for i:=0 to n do  begin
          if (getl(pro[i])='loop') then
           for j:=i downto 0 do begin
             if (pro[j]='do')then begin
                 last:=j;
                 if (checkbreak(j,i)<>-1) then
                 begin
                     pro[checkbreak(j,i)]:='goto '+inttostr(j+1);
                 end;
                 pro[i]:='if '+getco(pro[i])+ ' '+inttostr(last);
                 pro[j]:='do';
                 b:=true;
                 break;
             end;
             if (b=true) then break;
          end;
            if (b=true) then break;
      end;
         if (i=n)then c:=true;
         if (b=false) then c:=true;
         b:=false;
     until(c=true);
end;
procedure tr_for();
 var i,j,k:integer;
var co:string;
var n,last:integer;
var b,c:boolean;
function checkbreak(i,j:integer):integer;
 var r:integer;
 var k:integer;
 begin
      r:=-1;
      for k:=i+1 to j-1 do
      if (pro[k]='break') then r:=k;
      result:=r;
 end;
function getf(s:string;var first:string;var ends:string;var step:string):string;
var i,j,k:integer;
var r:string;
begin
     ends:='';
     first:='';
     step:='';
     r:='';
     if (length(s)>=20)then begin
     for i:=1 to length(s) do
       if(s[i]=' ') then break
       else r:=r+s[i];
       r:=r+' ';
     for j:=i+1 to length(s) do
     if (s[j]=' ') then break
     else first:=first+s[j];
     for k:=j+4 to length(s) do
     if (s[k]=' ') then break
     else ends:=ends+s[k];
     if (k=n) then step:='1' else
     begin
         for i:=k+6 to length(s) do
         step:=step+s[i];
     end;
     end;

     result:=r;
end;
procedure gets(s:string;var v:string;var st:string);
var i,j:integer;
begin
     v:='';
     st:='';

     for i:=1 to length(s) do
      if (s[i]='=') then
      break
      else v:=v+s[i];
      for j:=i+1 to length(s) do
        st:=st+s[j];
end;
var first,ends,step:string;
var v,st:string;
begin
     n:=length(pro)-1;
     b:=false;
     c:=false;
     repeat
      for i:=0 to n do  begin
          if (pro[i]='next') then
           for j:=i downto 0 do begin
             if (getf(pro[j],first,ends,step)='for ')then begin
                 last:=j;
                 if (checkbreak(j,i)<>-1) then
                 begin
                     pro[checkbreak(j,i)]:='goto '+inttostr(j);
                 end;
                 gets(first,v,st);
                 pro[i]:=v+'='+v+'+'+step+':if '+v+'<='+ends+' '+inttostr(j+1);
                 pro[j]:=first;
                 b:=true;
                 break;
             end;
             if (b=true) then break;
          end;
            if (b=true) then break;
      end;
         if (i=n)then c:=true;
         if (b=false) then c:=true;
         b:=false;
     until(c=true);
end;
procedure main(memo1:trichedit);
begin
   gett(memo1);
   tr_if();
   tr_while();
   tr_do();
   tr_for();
   tran();
end;
{解释结束}

procedure TForm43.RichEdit1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 label1.Caption:=inttostr(hang(richedit1.Text,richedit1.SelStart));
end;
procedure TForm43.RichEdit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 label1.Caption:=inttostr(hang(richedit1.Text,richedit1.SelStart));
end;
procedure TForm43.RunR1Click(Sender: TObject);
begin
main(richedit1);
end;

procedure TForm43.Button2Click(Sender: TObject);
var i:integer;
begin
memo2.Clear;
for i:=0 to length(pro)-1 do begin
memo2.Lines.Add(pro[i]);
end;
end;
end.
