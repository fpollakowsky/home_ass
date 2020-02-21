final List<double> angleFirst = <double>[1.6, 1.6 ,1.6 ,1.6];
final List<double> angleSecond = <double>[0, 0 ,0 ,0];
final List<double> containerHeight = <double>[0, 0 ,0 ,0];

containerAnimation(int index){
  if(containerHeight[index] == 0){
    switch(index){
      case 0:
        containerHeight[index] = 195;
        break;
      case 1:
        containerHeight[index] = 79;
        break;
      case 2:
        containerHeight[index] = 48;
        break;
      case 3:
        containerHeight[index] = 48;
        break;
    }
  }
  else{
    containerHeight[index] = 0;
  }

  for(var i = 0 ; i <= 3; i++ ) {
    if (i != index){
      containerHeight[i] =  0;
    }
  }

}

buttonAnimation(int index){
  if(angleFirst[index] == 0){
    angleFirst[index] = 1.6;
    angleSecond[index] = 0;
  }
  else{
    angleFirst[index] = 0;
    angleSecond[index] = 1.6;
  }
  for(var i = 0 ; i <= 3; i++ ) {
    if (i != index){
      angleFirst[i] =  0.0001;
      angleSecond[i] = 0.0001;
    }
  }
}