
import SimpleOpenNI.*; 

SimpleOpenNI kinect; 

PImage head;


PImage resultImage;
color trans = color(0, 0, 0, 0);

int[] userMap; // declare our images 

boolean calibrated;


void setup() {
  kinect = new SimpleOpenNI(this);
  kinect.setMirror(true);
  kinect.enableDepth();
  kinect.enableUser(SimpleOpenNI.SKEL_PROFILE_ALL);

  size(640, 480);

  resultImage = new PImage(640, 480, ARGB);


  head = loadImage("Head_red.png");
  
  
  /////****

  ////

}

void draw() {
  kinect.update();
////


  if (!calibrated) {
    image(kinect.depthImage(), 0, 0);
  }  

  IntVector userList = new IntVector();
  kinect.getUsers(userList);

  if (userList.size() > 0) {
    int userId = userList.get(0);

    if ( kinect.isTrackingSkeleton(userId)) {

      userMap = kinect.getUsersPixels(SimpleOpenNI.USERS_ALL);
      for (int i =0; i < userMap.length; i++) {
        // if the pixel is part of the user
        if (userMap[i] != 0) {
          // set the pixel to the color pixel
          resultImage.pixels[i] = kinect.depthImage().pixels[i];
        }
        else {
          //set it to the background
          resultImage.pixels[i] = trans;
        }
      }
      //update the pixel from the inner array to image
      resultImage.updatePixels();
      image(resultImage, 0, 0);

      drawSkeleton(userId);
    }

   
    PVector headPos = new PVector();
    kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_HEAD, headPos);
    kinect.convertRealWorldToProjective(headPos, headPos);
    println(headPos.z);
    float newImageWidth = map(headPos.z, 500, 2000, head.width, head.width/2);
    float newImageHeight = map(headPos.z, 500, 2000, head.width, head.width/2);
    image(head, headPos.x - newImageWidth/2 - 25, headPos.y - newImageHeight/2 - 50, newImageWidth, newImageHeight );
    
 
    
  }
  //c
}
void drawSkeleton(int userId) {
  stroke(0);
  strokeWeight(25);

  kinect.drawLimb(userId, SimpleOpenNI.SKEL_HEAD, SimpleOpenNI.SKEL_NECK);
  //image(head, SimpleOpenNI.SKEL_HEAD.x - head.width/2, SimpleOpenNI.SKEL_HEAD.y - head.height);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_NECK, SimpleOpenNI.SKEL_LEFT_SHOULDER);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, SimpleOpenNI.SKEL_LEFT_ELBOW);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_ELBOW, SimpleOpenNI.SKEL_LEFT_HAND);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_NECK, SimpleOpenNI.SKEL_RIGHT_SHOULDER);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, SimpleOpenNI.SKEL_RIGHT_ELBOW);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_ELBOW, SimpleOpenNI.SKEL_RIGHT_HAND);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, SimpleOpenNI.SKEL_TORSO);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, SimpleOpenNI.SKEL_TORSO);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_TORSO, SimpleOpenNI.SKEL_LEFT_HIP);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_HIP, SimpleOpenNI.SKEL_LEFT_KNEE);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_KNEE, SimpleOpenNI.SKEL_LEFT_FOOT);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_TORSO, SimpleOpenNI.SKEL_RIGHT_HIP);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_HIP, SimpleOpenNI.SKEL_RIGHT_KNEE);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_KNEE, SimpleOpenNI.SKEL_RIGHT_FOOT);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_HIP, SimpleOpenNI.SKEL_LEFT_HIP);

  noStroke();
 fill(0, 255, 0);
  /*
  drawJoint(userId, SimpleOpenNI.SKEL_HEAD);  

   drawJoint(userId, SimpleOpenNI.SKEL_NECK);
   drawJoint(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER);
   drawJoint(userId, SimpleOpenNI.SKEL_LEFT_ELBOW);
   drawJoint(userId, SimpleOpenNI.SKEL_NECK);
   drawJoint(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER);
   drawJoint(userId, SimpleOpenNI.SKEL_RIGHT_ELBOW);
   drawJoint(userId, SimpleOpenNI.SKEL_TORSO);
   drawJoint(userId, SimpleOpenNI.SKEL_LEFT_HIP);
   drawJoint(userId, SimpleOpenNI.SKEL_LEFT_KNEE);
   drawJoint(userId, SimpleOpenNI.SKEL_RIGHT_HIP);
   drawJoint(userId, SimpleOpenNI.SKEL_LEFT_FOOT);
   drawJoint(userId, SimpleOpenNI.SKEL_RIGHT_KNEE);
   drawJoint(userId, SimpleOpenNI.SKEL_LEFT_HIP);
   drawJoint(userId, SimpleOpenNI.SKEL_RIGHT_FOOT);
   drawJoint(userId, SimpleOpenNI.SKEL_RIGHT_HAND);
   drawJoint(userId, SimpleOpenNI.SKEL_LEFT_HAND);
   */
}

float getJointDistance(int userId, int jointID1, int jointID2) {
  PVector joint1 = new PVector();
  PVector joint2 = new PVector();
  kinect.getJointPositionSkeleton(userId, jointID1, joint1);
  kinect.getJointPositionSkeleton(userId, jointID2, joint2);
  return PVector.dist(joint1, joint2);
} 

void drawJoint(int userId, int jointID) {
  PVector joint = new PVector();
  float confidence = kinect.getJointPositionSkeleton(userId, jointID, joint);
  if (confidence < 0.5) {
    return;
  }
  PVector convertedJoint = new PVector();
  kinect.convertRealWorldToProjective(joint, convertedJoint);
  ellipse(convertedJoint.x, convertedJoint.y, 5, 5);
}
// user-tracking callbacks! 
void onNewUser(int userId) {
  println("start pose detection");
  kinect.startPoseDetection("Psi", userId);
}

void onEndCalibration(int userId, boolean successful) {
  if (successful) {
    println(" User calibrated !!!");
    kinect.startTrackingSkeleton(userId);
    calibrated = true;
  }
  else {
    println(" Failed to calibrate user !!!");
    kinect.startPoseDetection("Psi", userId);
  }
}

void onStartPose(String pose, int userId) {
  println("Started pose for user");
  kinect.stopPoseDetection(userId);
  kinect.requestCalibrationSkeleton(userId, true);
}
