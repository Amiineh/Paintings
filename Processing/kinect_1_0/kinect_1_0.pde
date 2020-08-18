import SimpleOpenNI.*;

//import java.awt.Polygon;

//Gesture gestureArray[];
//final int nGestures = 36;  // Number of gestures
//final int minMove = 3;     // Minimum travel for a new point
//int currentGestureID;

//Polygon tempP;
//int tmpXp[];
//int tmpYp[];

//Generate a SimpleOpenNI object
SimpleOpenNI kinect;

//Vectors used to calculate the center of the mass
PVector com = new PVector();
PVector com2d = new PVector();

// Colors
color[] colors = {0, #7EF0DF, #911CBC, #FA9426, #09E023, #FEFF21, #BCFFFB};


//Up
float LeftshoulderAngle = 0;
float LeftelbowAngle = 0;
float RightshoulderAngle = 0;
float RightelbowAngle = 0;

//Timer variables
float a = 0;
int cntr = 0;


void setup() {
        size(1280, 480);
        kinect = new SimpleOpenNI(this);
        kinect.setMirror(true);
        kinect.enableDepth();
        //kinect.enableIR();
        kinect.enableUser();// because of the version this change
        //size(640, 480);
        fill(255, 0, 0);
        //size(kinect.depthWidth()+kinect.irWidth(), kinect.depthHeight());
        background(255);
        
}

void draw() {
        kinect.update();
        //image(kinect.depthImage(), 0, 0);
        //image(kinect.irImage(),kinect.depthWidth(),0);
        image(kinect.userImage(),width/2, 0);
        
        IntVector userList = new IntVector();
        kinect.getUsers(userList);
        if (userList.size() > 0) {
                int userId = userList.get(0);
                //If we detect one user we have to draw it
                if( kinect.isTrackingSkeleton(userId)) {
                        //DrawSkeleton
                        drawSkeleton(userId);
                }
        }
        
}
//Draw the skeleton
void drawSkeleton(int userId) {
        drawLine(userId, SimpleOpenNI.SKEL_RIGHT_KNEE, SimpleOpenNI.SKEL_RIGHT_HAND);
        drawLine(userId, SimpleOpenNI.SKEL_HEAD, SimpleOpenNI.SKEL_LEFT_HAND);
        
        //drawLine(userId, SimpleOpenNI.SKEL_RIGHT_HAND, SimpleOpenNI.SKEL_LEFT_HAND);
        
        //drawLine(userId, SimpleOpenNI.SKEL_LEFT_ELBOW, SimpleOpenNI.SKEL_LEFT_HAND);
        //drawLine(userId, SimpleOpenNI.SKEL_RIGHT_ELBOW, SimpleOpenNI.SKEL_RIGHT_HAND);
        
        //drawLine(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, SimpleOpenNI.SKEL_LEFT_HAND);
        //drawLine(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, SimpleOpenNI.SKEL_RIGHT_HAND);
        
        //drawLine(userId, SimpleOpenNI.SKEL_TORSO, SimpleOpenNI.SKEL_LEFT_HAND);
        //drawLine(userId, SimpleOpenNI.SKEL_TORSO, SimpleOpenNI.SKEL_RIGHT_HAND);
        
        //drawCircle(userId, SimpleOpenNI.SKEL_LEFT_HAND, 0);
        //drawCircle(userId, SimpleOpenNI.SKEL_RIGHT_HAND, 4);
        //drawCircle(userId, SimpleOpenNI.SKEL_HEAD, 2);
        //drawCircle(userId, SimpleOpenNI.SKEL_LEFT_HIP, 3);
        //drawCircle(userId, SimpleOpenNI.SKEL_RIGHT_HIP, 4);
        
        //drawRing(userId, SimpleOpenNI.SKEL_RIGHT_HAND, 0);
        //drawRing(userId, SimpleOpenNI.SKEL_LEFT_HIP, 0);
}


//void drawBrush(int userId, int jointId, int colorId){
//      PVector joint = new PVector();
//      float confidence = kinect.getJointPositionSkeleton(userId, jointId, joint);
      
//      if (confidence < 0.6)
//        return;
        
//      PVector convertedJoint = new PVector();
//      kinect.convertRealWorldToProjective(joint, convertedJoint);
      
//      Gesture J;
//      for (int g=0; g<nGestures; g++) {
//        if ((J=gestureArray[g]).exists) {
//          if (g!=currentGestureID) {
//            advanceGesture(J);
//          } else if (!mousePressed) {
//            advanceGesture(J);
//          }
//        }
//      }
      
//      currentGestureID = (currentGestureID+1) % nGestures;
//      Gesture G = gestureArray[currentGestureID];
//      G.clear();
//      G.clearPolys();
//      G.addPoint(mouseX, mouseY);
      
//        if (currentGestureID >= 0) {
//    Gesture G = gestureArray[currentGestureID];
//    if (G.distToLast(mouseX, mouseY) > minMove) {
//      G.addPoint(mouseX, mouseY);
//      G.smooth();
//      G.compile();
//    }
//  }
//}


//void advanceGesture(Gesture gesture) {
//  // Move a Gesture one step
//  if (gesture.exists) { // check
//    int nPts = gesture.nPoints;
//    int nPts1 = nPts-1;
//    Vec3f path[];
//    float jx = gesture.jumpDx;
//    float jy = gesture.jumpDy;

//    if (nPts > 0) {
//      path = gesture.path;
//      for (int i = nPts1; i > 0; i--) {
//        path[i].x = path[i-1].x;
//        path[i].y = path[i-1].y;
//      }
//      path[0].x = path[nPts1].x - jx;
//      path[0].y = path[nPts1].y - jy;
//      gesture.compile();
//    }
//  }
//}

//void clearGestures() {
//  for (int i = 0; i < nGestures; i++) {
//    gestureArray[i].clear();
//  }
//}

void drawCircle(int userId, int jointID, int colorId){
      PVector joint = new PVector();
      float confidence = kinect.getJointPositionSkeleton(userId, jointID, joint);
      
      if (confidence < 0.6)
        return;
        
      PVector convertedJoint = new PVector();
      kinect.convertRealWorldToProjective(joint, convertedJoint);
      
      int r = 50;
      stroke(colors[colorId], 100);
      //noStroke();
      fill(colors[colorId], 0);
      
      ellipse(convertedJoint.x, convertedJoint.y, r, r);
      fill (255, 0, 0);
      ellipse(width/2 + convertedJoint.x, convertedJoint.y, 10, 10);
}



void drawLine(int userId, int jointID1, int jointID2){
      PVector joint1 = new PVector();
      PVector joint2 = new PVector();
      float confidence = kinect.getJointPositionSkeleton(userId, jointID1, joint1) +
                          kinect.getJointPositionSkeleton(userId, jointID2, joint2);
      
      if(confidence < 1) {
              return;
      }
        
      PVector convertedJoint1 = new PVector();
      kinect.convertRealWorldToProjective(joint1, convertedJoint1);
      PVector convertedJoint2 = new PVector();
      kinect.convertRealWorldToProjective(joint2, convertedJoint2);
      
      stroke(20, 50);
      strokeWeight(1);
      line(convertedJoint1.x, convertedJoint1.y, convertedJoint2.x, convertedJoint2.y);
      
      stroke(255, 0, 0);
      strokeWeight(3);
      float x1 = max(width/2+convertedJoint1.x, width/2);
      float x2 = max(width/2+convertedJoint2.x, width/2);
      line(x1, convertedJoint1.y, x2, convertedJoint2.y);
}


void drawJoint(int userId, int jointID) {
        PVector joint = new PVector();
        float confidence = kinect.getJointPositionSkeleton(userId, jointID,
                                                           joint);
        if(confidence < 0.5) {
                return;
        }
        PVector convertedJoint = new PVector();
        kinect.convertRealWorldToProjective(joint, convertedJoint);
        ellipse(convertedJoint.x, convertedJoint.y, 5, 5);
}
//Generate the angle
float angleOf(PVector one, PVector two, PVector axis) {
        PVector limb = PVector.sub(two, one);
        return degrees(PVector.angleBetween(limb, axis));
}

//Calibration not required

void onNewUser(SimpleOpenNI kinect, int userID) {
        println("Start skeleton tracking");
        kinect.startTrackingSkeleton(userID);
}

void onLostUser(SimpleOpenNI curContext, int userId) {
        println("onLostUser - userId: " + userId);
}


void keyPressed(){
  if (key == 'r')
    background(255);
}
