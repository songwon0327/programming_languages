program score (input, output);
    type
        Lptr = ^Student;
        Student = record
            sname, snum : string;
            kor, mat, eng, total : integer;
            next : Lptr;
        end;    

	var
        stuPtr, cur : Lptr;
        stuImpo : array of Student;
        i , cnt : integer;

    procedure swap(x, y : integer);
        var
            tmp : integer;
            tmpImpo  : Student;
        begin
            tmpImpo := stuImpo[x];
            stuImpo[x] := stuImpo[y];
            stuImpo[y] := tmpImpo;

            tmp := x;
            x := y;
            y := tmp;
        end;    

    procedure partition( leftInd, rightInd : integer; var split : integer);
        var 
            pivot, left, right : integer;
        begin
            pivot := stuImpo[(leftInd)].total;
            left := leftInd;
            right := rightInd;

            repeat
                while (stuImpo[left].total >= pivot) and (left < rightInd) do
                    left := left+1;
                while (stuImpo[right].total < pivot) and (right > leftInd) do
                    right := right-1;    
                if left < right then
                    swap(left, right);
            until (left >= right);
            
            split := right;
            swap(leftInd,right);
        end;        

    procedure quickSort(low, high : integer);
        var
            split : integer;
        begin
            if low < high then
                begin
                    partition(low, high, split);
                    quickSort(low, split-1);
                    quickSort(split+1, high);
                end;
            end;

	begin
        new(stuPtr);
        cur := stuPtr;
        cnt := 0;

        while (not eof(input)) do   
            begin
                readln(cur^.kor, cur^.mat, cur^.eng, cur^.sname, cur^.snum);
                if cur^.kor = 999
                    then Break;   
                cur^.total := cur^.kor + cur^.mat + cur^.eng;
                new(cur^.next);    
                cur := cur^.next;
                cur^.next := NIL;
                cnt := cnt+1;
            end; 

        setLength(stuImpo, cnt);    
        cur := stuPtr;    
        i := 0;

        while cur^.next <> NIL do
            begin
                stuImpo[i] := cur^;
                i := i+1;
                cur :=cur^.next;
            end;     
        
        quickSort(0,cnt-1);
        i := 0;
        writeln('[rank] [name] [number] [total score]');
        repeat
            writeln(i+1:3, stuImpo[i].sname, stuImpo[i].snum, '|', stuImpo[i].total:7);
            i := i+1;
        until (i+1 > cnt)    
	end.