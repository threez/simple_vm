declarations 
  integer i1, i2, n, s1. 
begin 
  read n;
  i1 := 0;
  i2 := 1;
  while n > 0 do
    s1 := i1;
    i1 := i2;
    i2 := s1 + i2;
    n := n - 1;
  end;
  write i1;
end

