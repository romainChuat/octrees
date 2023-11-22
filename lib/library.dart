

import 'dart:math';

import 'package:flutter/material.dart';

createAppBar(){
  return AppBar();
}

///TODO VERIFICATION VALIDITE DU CALCUL
int treeLevel(String treeString){
  int levelNumber = 0;
  int i = 1;
  while(i<treeString.length){
    int countCurrentD = 0;
    int j = i;
    levelNumber ++;
    while(j < i+8 && j<treeString.length){
      if(treeString[j] == 'D'){
        countCurrentD ++;
      }
      j++;
    }
    if(countCurrentD > 1 ){
      i += ((countCurrentD-1) * 8) + 8;
    }else{
      i = j;
    }
  }
  return levelNumber;
}

int treeSide (int level){
  return pow(2 , level) as int;
}