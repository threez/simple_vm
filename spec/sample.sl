declarations 
  integer f, n. 
begin 
  read n; 
  if n < 0 then 
    write 0; 
  else 
    f := 1; 
    while n > 0 do 
      f := f * n; 
      n := n - 1; 
    od; 
    write f; 
  fi;
end