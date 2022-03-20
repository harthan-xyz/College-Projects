function xx = dtmfdial(keyNames,fs)
dtmf.keys = ...
    ['1','2','3','A';
     '4','5','6','B';
     '7','8','9','C';
     '*','0','#','D'];
 
 keyNames = dtmf.keys;
 
dtmf.coltones = ones(4,1)*[1209,1336,1477,1633];
dtmf.rowtones = [697;770;852;941]*ones(1,4);
 
 xx = []; 
 
  
 N = 800;
 ts = 1/fs;
 pit = 2 * pi * ts;
 
 for ii = 1: 4
     for jj = 1 : 3
     [ii,jj] = find('1' == dtmf.keys);
     [ii,jj] = find('2' == dtmf.keys);
     [ii,jj] = find('3' == dtmf.keys);
     [ii,jj] = find('4' == dtmf.keys);
     [ii,jj] = find('A' == dtmf.keys);
     
     xx = [xx ,cos(pit*dtmf.rowtones(ii))];
     xx = [xx, cos(pit*dtmf.coltones(jj))];
     
     end
 end
     
 soundsc(xx,fs);
 end 

 