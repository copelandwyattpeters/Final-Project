class Timer{
  float timeElapsed;
  float interval;
  boolean isRepeating;
  boolean hasElapsed;
  boolean paused;
  
  Timer(float interval){
    this.interval = interval;
    this.timeElapsed = 0;
    this.isRepeating = true;
    this.hasElapsed = false;
    this.paused = false;
  }
  
  boolean hasElapsed(){
    if ((millis()-this.timeElapsed) >= this.interval){
      return true;
    }
    else{
      return false;
    }
  }
}
