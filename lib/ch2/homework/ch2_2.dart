void testFun(List<int> nums){
  int maxNum = 0;
  double minNum = double.infinity; //초기화를 nums[0]으로 두면 int로 타입 통일 가능
  int sumNum = 0;
  int avgNum = 0;

  for(var i = 0; i < nums.length; i++){
    if(nums[i] > maxNum) {
      maxNum = nums[i];
    }
    if(nums[i] < minNum){
      minNum = nums[i].toDouble();
    }

    sumNum += nums[i];
  }
  minNum.toInt();
  avgNum = sumNum ~/ nums.length;

  print("""
  최고점수 : $maxNum
  최저점수 : ${minNum.toInt()}
  점수총합 : $sumNum
  점수평균 : $avgNum
  """);
}

void main(){
  List<int> numbers1 = [10, 5, 20, 4];
  List<int> numbers2 = [3, 5, 1, 3];

  testFun(numbers1);
  testFun(numbers2);
}