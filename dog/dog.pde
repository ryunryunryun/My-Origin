/**
* This program allows you to play with a dog.
*
* @author     Ryu Fujiwara
* @version    1.0
* @since      2015-05-02
*/

color bodyColor;

// BARK
float barkSpeed = 0; // relative position of the upper mouth
boolean barkControl = true; // true = up(-), false = down(+)
int barkCount = 0; // counts number of bark

// WALK
float rotateAngleW = 0; // used to define an agnle of a rotation
boolean rotateControlW = true; // true = counterclockwise, false = clockwise
int rotateCountW = 0; // counts number of wave

// FOOD
float facePositionY = 0; // relative posistion of its face
float barkPosition = 0; // relative position of mouse movement
boolean foodControl = true; // true = down, false = down;
boolean startEating = false; // true = eat, false = no
int waitCountF = 0; // frame passed while eating
int waitFrameF = 160; // keep eating for set time 
float foodAmount = 100; // amount of food left
float foodLevel = 0; // relative height of food left

// NON CAPISCO
float rotateAngleQ = 0; // used to define an angle of rotation
boolean rotateControlQ = true; // same as above
int rotateCount = 0; // counts number of rotation
int faceCenterX = 223; // x-coordinate of a center of face
int faceCenterY = 302; // y-coordinate of a center of face
int waitCount = 0; // frame passed being puzzled
int waitFrame = 20; // keep puzzled for set waitTime


// set back to false each time
boolean buttonBark = false;
boolean buttonWalk = false;
boolean buttonFood = false;
boolean buttonHand = false;
boolean nonCapisco = false; // cf:) "i dont understand" in italian
boolean isButtonBarkPressed = false;
boolean isButtonWalkPressed = false;
boolean isButtonFoodPressed = false;
boolean isButtonHandPressed = false;
boolean isNonCapiscoPressed = false;

// stores colors. 
// TODO: EDIT colorTransform() to make user be able to add color freely

color[] bodyColors = {
color(210, 94, 44),
color(79, 57, 47),
color(124, 83, 53),
color(222, 176, 55),
color(231, 225, 143),
color(221, 221, 221),
color(15, 82, 188),
color(219, 0, 21),
color(11, 218, 81)
};

// create screen
void setup() {
  size(400, 650);
  bodyColor = bodyColors[0];
}

// draws everything
void draw() {
  background(255);
  
  drawBackground();
  
  stroke(0);
  colorButton();
  createMultipleButtons();
  
  drawTail(bodyColor);
  drawBody(bodyColor);
  drawRLeg(bodyColor);
  drawLLeg(bodyColor);
  drawFace(bodyColor);
  moveBark(buttonBark);
  moveWalk(buttonWalk);
  moveQuestion(nonCapisco);
  moveFood(buttonFood);
}

void mouseClicked () {
  test();
  colorTransform();
  buttonControl();
}

////// DON'T FORGET TO TRANSFORM COORDINATE BACK TO (0,0)!!!!!
////// LET BARKSPEED = 0 WHEN FINISHED!


// draw background
void drawBackground() {
  noStroke();
  fill(186, 160, 94); // ground
  rect(0, 400, 400, 250);
  
  fill(98, 161, 83); //wall
  rect(0, 0, 650, 400);
  
  fill (123, 137, 66);
  for (int i = 0; i < 10; i++) {
    rect(40 * i, 0, 20, 400);
  }
  
  fill (91, 79, 61);
  rect(25, 50, 200, 200); // outer frame of a window
  
  fill (25, 135, 222);
  rect(35, 60, 180, 180); // window
  
  fill (255, 255, 0);
  arc(35, 60, 140, 140, 0, HALF_PI); // sun (maybe going to erace)
  
  fill (91, 79, 61);
  rect (120, 50, 10, 200); // inner frame of a window
  rect (25, 145, 200, 10);

}

// draw facial parts
void drawFace(color bodyColor) {
  fill(bodyColor);
  
  translate(faceCenterX, faceCenterY);
  rotate(radians(rotateAngleQ));
 
  drawEar(faceCenterX, faceCenterY - facePositionY); // ear
  drawFaceOnly(faceCenterX, faceCenterY - facePositionY); // face
  
  fill(50);
  ellipse(197 - faceCenterX, 262 - faceCenterY + facePositionY,
           15, 15); // right eye
  ellipse(241 - faceCenterX, 262 - faceCenterY + facePositionY, 
           15, 15); // left eye
  triangle(211 - faceCenterX, 295 + barkSpeed - faceCenterY + facePositionY,
            229 - faceCenterX, 295 + barkSpeed - faceCenterY + facePositionY, 
             220 - faceCenterX, 310 + barkSpeed - faceCenterY + facePositionY); //nose
 
  resetMatrix();
}

// draws only face
void drawFaceOnly(float x, float y) {
  
  beginShape();
    curveVertex(203 - x, 158 - y); // 1
    curveVertex(212 - x, 162 - y); 
    curveVertex(218 - x, 168 - y); 
    curveVertex(221 - x, 173 - y);
    curveVertex(226 - x, 164 - y);
    curveVertex(231 - x, 166 - y); // 2
    curveVertex(238 - x, 166 - y);
    curveVertex(243 - x, 171 - y);
    curveVertex(245 - x, 175 - y); // 3
    curveVertex(252 - x, 170 - y);
    curveVertex(259 - x, 172 - y);
    curveVertex(263 - x, 179 - y); 
    curveVertex(265 - x, 186 - y); // 4
    curveVertex(270 - x, 192 - y);
    curveVertex(269 - x, 200 - y);
    curveVertex(273 - x, 206 - y); // 5
    curveVertex(271 - x, 211 - y);
    curveVertex(268 - x, 216 - y);
    curveVertex(274 - x, 220 - y); // 6
    curveVertex(277 - x, 230 - y);
    curveVertex(272 - x, 242 - y);
    curveVertex(268 - x, 250 - y); // 7
    curveVertex(274 - x, 254 - y);
    curveVertex(280 - x, 261 - y);
    curveVertex(274 - x, 266 - y);
    curveVertex(278 - x, 273 - y); // 8
    curveVertex(281 - x, 276 - y);
    curveVertex(271 - x, 282 - y);
    curveVertex(278 - x, 287 - y);
    curveVertex(281 - x, 293 - y); // 9
    curveVertex(276 - x, 299 - y);
    curveVertex(269 - x, 300 - y);
    curveVertex(276 - x, 309 - y); // 10
    curveVertex(268 - x, 313 - y); // **
    curveVertex(261 - x, 312 - y);
    curveVertex(256 - x, 319 - y); // 11
    curveVertex(253 - x, 318 - y); 
    curveVertex(250 - x, 312 - y);
    curveVertex(243 - x, 319 - y);
    curveVertex(240 - x, 324 - y);
    curveVertex(236 - x, 319 - y); // 12
    curveVertex(228 - x, 323 - y); 
    curveVertex(222 - x, 316 - y);
    curveVertex(219 - x, 322 - y);
    curveVertex(216 - x, 324 - y); // 13
    curveVertex(212 - x, 322 - y);
    curveVertex(208 - x, 320 - y);
    curveVertex(202 - x, 319 - y); // 14
    curveVertex(197 - x, 322 - y);
    curveVertex(189 - x, 318 - y);
    curveVertex(185 - x, 314 - y);
    curveVertex(178 - x, 319 - y); // 15 **
    curveVertex(174 - x, 311 - y);
    curveVertex(171 - x, 310 - y);
    curveVertex(167 - x, 306 - y); // 16
    curveVertex(170 - x, 300 - y);
    curveVertex(171 - x, 298 - y);
    curveVertex(162 - x, 299 - y);
    curveVertex(159 - x, 297 - y); // 17
    curveVertex(158 - x, 293 - y);
    curveVertex(157 - x, 288 - y);
    curveVertex(163 - x, 286 - y);
    curveVertex(159 - x, 285 - y); // 18
    curveVertex(162 - x, 285 - y);
    curveVertex(157 - x, 281 - y); 
    curveVertex(154 - x, 277 - y); // 19
    curveVertex(158 - x, 275 - y);
    curveVertex(163 - x, 272 - y);
    curveVertex(157 - x, 268 - y);
    curveVertex(154 - x, 262 - y); // 20
    curveVertex(159 - x, 257 - y);
    curveVertex(163 - x, 255 - y);
    curveVertex(166 - x, 252 - y);
    curveVertex(170 - x, 251 - y); // 21
    curveVertex(161 - x, 245 - y);
    curveVertex(161 - x, 240 - y);
    curveVertex(163 - x, 235 - y);
    curveVertex(163 - x, 231 - y);
    curveVertex(165 - x, 230 - y);
    curveVertex(162 - x, 223 - y); // 22
    curveVertex(163 - x, 218 - y);
    curveVertex(166 - x, 213 - y);
    curveVertex(165 - x, 210 - y);
    curveVertex(162 - x, 205 - y); // 23
    curveVertex(167 - x, 200 - y);
    curveVertex(169 - x, 194 - y);
    curveVertex(165 - x, 187 - y);
    curveVertex(167 - x, 177 - y); // 24
    curveVertex(172 - x, 172 - y);
    curveVertex(179 - x, 169 - y);
    curveVertex(186 - x, 172 - y);
    curveVertex(191 - x, 175 - y);
    curveVertex(195 - x, 166 - y); // 25
    curveVertex(199 - x, 166 - y);
    curveVertex(203 - x, 158 - y); // 1
    curveVertex(212 - x, 162 - y); 
    curveVertex(218 - x, 168 - y); 
  endShape();
}

// draw ear
void drawEar(float x, float y) {
  
  beginShape();
    curveVertex(168 - x, 189 - y);
    curveVertex(151 - x, 181 - y);
    curveVertex(145 - x, 184 - y);
    curveVertex(140 - x, 191 - y);
    curveVertex(144 - x, 198 - y);
    curveVertex(146 - x, 202 - y);
    curveVertex(135 - x, 206 - y);
    curveVertex(138 - x, 215 - y);
    curveVertex(130 - x, 217 - y);
    curveVertex(132 - x, 223 - y);
    curveVertex(129 - x, 231 - y);
    curveVertex(134 - x, 236 - y);
    curveVertex(125 - x, 240 - y);
    curveVertex(123 - x, 247 - y);
    curveVertex(129 - x, 252 - y);
    curveVertex(131 - x, 255 - y);
    curveVertex(123 - x, 262 - y);
    curveVertex(121 - x, 269 - y);
    curveVertex(126 - x, 270 - y);
    curveVertex(133 - x, 271 - y);
    curveVertex(130 - x, 279 - y);
    curveVertex(134 - x, 288 - y);
    curveVertex(143 - x, 288 - y);
    curveVertex(144 - x, 283 - y);
    curveVertex(150 - x, 291 - y);
    curveVertex(160 - x, 289 - y);
    curveVertex(178 - x, 290 - y);
    
    vertex(267 - x, 288 - y);
    
    curveVertex(271 - x, 285 - y);
    curveVertex(285 - x, 285 - y);
    curveVertex(291 - x, 281 - y);
    curveVertex(288 - x, 271 - y);
    curveVertex(293 - x, 267 - y);
    curveVertex(302 - x, 264 - y);
    curveVertex(297 - x, 257 - y);
    curveVertex(292 - x, 252 - y);
    curveVertex(303 - x, 251 - y);
    curveVertex(305 - x, 242 - y);
    curveVertex(302 - x, 237 - y);
    curveVertex(305 - x, 228 - y);
    curveVertex(299 - x, 224 - y);
    curveVertex(295 - x, 220 - y);
    curveVertex(304 - x, 216 - y);
    curveVertex(292 - x, 204 - y);
    curveVertex(286 - x, 206 - y);
    curveVertex(292 - x, 193 - y);
    curveVertex(282 - x, 185 - y);
    curveVertex(274 - x, 179 - y);
    curveVertex(264 - x, 181 - y);
    curveVertex(254 - x, 181 - y);
  
    curveVertex(168 - x, 189 - y);
    curveVertex(151 - x, 181 - y);
    curveVertex(145 - x, 184 - y);
  endShape();
}

/* discarded - intended to create hair using equation, but abandoned
               because it was so unnatural.

// draw one MOFUMOFU unit (vertical 30, horizontal 20)
void drawMofuMofu(float beginX, float beginY, float angle) {
  float endPointX = beginX + 30 * cos(radians(angle));
  float endPointY = beginY + 30 * sin(radians(angle));
  //float midPointX = beginX + 15;
  //float midPointY = beginY - 20;
  float midPointX = beginX + 25 * cos(radians(angle) + acos(3/5));
  float midPointY = beginY - 25 * sin(radians(angle) + acos(3/5));
  curveVertex(beginX, beginY);
  //ellipse(beginX , beginY, 10, 10);
  curveVertex(midPointX, midPointY);
  //ellipse(midPointX, midPointY, 15, 15);
  curveVertex(endPointX, endPointY);
  //ellipse(endPointX, endPointY, 20, 20);
}
*/

// draw a right (seen from the user) leg
void drawRLeg(color bodyColor) {
  fill(bodyColor);
  
  beginShape();
    curveVertex(182, 306);
    curveVertex(179, 316);
    curveVertex(166, 329);
    curveVertex(163, 336);
    curveVertex(167, 346);
    curveVertex(171, 349);
    curveVertex(163, 357);
    curveVertex(163, 366);
    curveVertex(169, 370);
    curveVertex(162, 378);
    curveVertex(169, 390);
    curveVertex(167, 397);
    curveVertex(167, 405);
    curveVertex(174, 412);
    curveVertex(180, 409);
    curveVertex(181, 419);
    curveVertex(192, 418);
    curveVertex(196, 414);
    curveVertex(204, 422);
    curveVertex(210, 414);
    curveVertex(209, 410);
    curveVertex(220, 407);
    curveVertex(216, 397);
    curveVertex(224, 391);
    curveVertex(219, 383);
    curveVertex(216, 377);
    curveVertex(224, 369);
    curveVertex(218, 364);
    curveVertex(227, 356);
    curveVertex(220, 349);
    curveVertex(225, 338);
    curveVertex(215, 330);
    curveVertex(211, 321);
    curveVertex(207, 307);
  
    curveVertex(182, 306);
    curveVertex(179, 316);
    curveVertex(166, 329);
  endShape();
}

// inverse and draw right leg, which is a left leg
void drawLLeg(color bodyColor) {
  beginShape();
    curveVertex(265, 309);
    curveVertex(277, 317);
    curveVertex(285, 328);
    curveVertex(277, 336);
    curveVertex(289, 342);
    curveVertex(285, 351);
    curveVertex(292, 358);
    curveVertex(287, 368);
    curveVertex(297, 376);
    curveVertex(296, 387);
    curveVertex(284, 388);
    curveVertex(291, 399);
    curveVertex(289, 403);
    curveVertex(282, 409);
    curveVertex(271, 419);
    curveVertex(262, 413);
    curveVertex(249, 422);
    curveVertex(243, 414);
    curveVertex(246, 402);
    curveVertex(236, 400);
    curveVertex(244, 389);
    curveVertex(232, 385);
    curveVertex(239, 378);
    curveVertex(229, 365);
    curveVertex(236, 359);
    curveVertex(229, 350);
    curveVertex(238, 342);
    curveVertex(228, 334);
    curveVertex(237, 315);
  
    curveVertex(265, 309);
    curveVertex(277, 317);
    curveVertex(285, 328);
  endShape();
}

// draw a body and legs behind
void drawBody(color bodyColor) {
  fill(bodyColor);
  
  beginShape();
    curveVertex(173, 345);
    curveVertex(160, 346);
    curveVertex(155, 354);
    curveVertex(158, 360);
    curveVertex(148, 364);
    curveVertex(153, 375);
    curveVertex(146, 379);
    curveVertex(151, 387);
    curveVertex(140, 389);
    curveVertex(143, 397);
    curveVertex(140, 403);
    curveVertex(128, 405);
    curveVertex(136, 418);
    curveVertex(147, 413);
    curveVertex(157, 422);
    curveVertex(168, 406);
    curveVertex(189, 407);
    curveVertex(206, 415);
    curveVertex(225, 420);
    curveVertex(228, 410);
    curveVertex(238, 424);
    curveVertex(246, 414);
    curveVertex(263, 410);
    curveVertex(270, 401);
    curveVertex(292, 416);
    curveVertex(308, 422);
    curveVertex(317, 413);
    curveVertex(323, 400);
    curveVertex(313, 403);
    curveVertex(314, 393);
    curveVertex(316, 385);
    curveVertex(302, 382);
    curveVertex(309, 371);
    curveVertex(295, 369);
    curveVertex(299, 357);
    curveVertex(295, 346);
    curveVertex(287, 336);
    curveVertex(262, 319);
    curveVertex(225, 306);
    curveVertex(198, 307);
    curveVertex(183, 333);
  
    curveVertex(173, 345);
    curveVertex(160, 346);
    curveVertex(155, 354);
  endShape();
} 

// draw a tail
void drawTail(color bodyColor) {
  fill(bodyColor);
  float x = 300;
  float y = 393;
  translate(x, y);
  
  rotate(radians(rotateAngleW));
  
  beginShape();
    curveVertex(297 - x, 378 - y);
    curveVertex(303 - x, 366 - y);
    curveVertex(312 - x, 366 - y);
    curveVertex(313 - x, 353 - y);
    curveVertex(325 - x, 353 - y);
    curveVertex(323 - x, 339 - y);
    curveVertex(335 - x, 340 - y);
    curveVertex(335 - x, 328 - y);
    curveVertex(348 - x, 331 - y);
    curveVertex(356 - x, 325 - y);
    curveVertex(362 - x, 335 - y);
    curveVertex(374 - x, 335 - y);
    curveVertex(373 - x, 346 - y);
    curveVertex(384 - x, 350 - y);
    curveVertex(388 - x, 358 - y);
    curveVertex(382 - x, 362 - y);
    curveVertex(382 - x, 377 - y);
    curveVertex(368 - x, 372 - y);
    curveVertex(365 - x, 383 - y);
    curveVertex(354 - x, 387 - y);
    curveVertex(345 - x, 383 - y);
    curveVertex(340 - x, 391 - y);
    curveVertex(340 - x, 393 - y);
    curveVertex(332 - x, 389 - y);
    curveVertex(327 - x, 398 - y);
    curveVertex(306 - x, 400 - y);
    curveVertex(297 - x, 387 - y);
  
    curveVertex(297 - x, 378 - y);
    curveVertex(303 - x, 366 - y);
    curveVertex(312 - x, 366 - y);
  endShape();
  
  resetMatrix();
}

// puts food in front of it
// memo: LT(181, 392) RT(270, 392) LB(197, 421) RB(254, 421) TP(224, 382)
void drawDish() {
   resetMatrix(); 
   fill(184, 101, 204);
    
    beginShape();
      vertex(181, 392);
      vertex(270, 392);
      vertex(254, 421);
      vertex(197, 421);
    
      vertex(181, 392);
      vertex(270, 392);
      vertex(254, 421);
    endShape();
}

// draw food on a dish
void drawFood() {
   fill(63, 45, 24);
   
   beginShape();
     vertex(254, 392);
     bezierVertex(225.5, 360 + foodLevel, 225.5, 360 + foodLevel, 197, 392);
   endShape();
}

// controls bark motion
void barkD(){
    if (barkControl) { // moves its mouth upward
      barkSpeed -= 2; // can change a speed of bark
      
      if (barkSpeed < -20) {
        barkControl = false;
      }
    }
    else { // moves its mouth downward
      barkSpeed += 2; // can change a speed of bark
      
      if (barkSpeed > 0) {
        barkSpeed = 0;
        barkControl = true;
        barkCount ++;
        
        if (barkCount == 1) { // chnage here to set bark number
          barkCount = 0;
          buttonBark = false;
        }
      }
    }
}

// bark!!! if bark is true, then do this operation
void moveBark(boolean bark) { 
  noFill();
  scale(0.9);
  translate(25, 50);
  
  if(bark) {
    barkD();
  
    // upper mouth
    beginShape();
      curveVertex(180, 291 + barkSpeed + barkPosition);
      curveVertex(175, 290 + barkSpeed + barkPosition);
      curveVertex(169, 294 + barkSpeed + barkPosition);
      curveVertex(175, 297 + barkSpeed + barkPosition);
      curveVertex(182, 297 + barkSpeed + barkPosition);
      curveVertex(186, 294 + barkSpeed + barkPosition);
      curveVertex(192, 298 + barkSpeed + barkPosition);
      curveVertex(196, 296 + barkSpeed + barkPosition);
      curveVertex(199, 292 + barkSpeed + barkPosition);
      curveVertex(206, 301 + barkSpeed + barkPosition);
      curveVertex(212, 295 + barkSpeed + barkPosition);
      curveVertex(220, 301 + barkSpeed + barkPosition);
      curveVertex(228, 296 + barkSpeed + barkPosition);
      curveVertex(237, 300 + barkSpeed + barkPosition);
      curveVertex(244, 294 + barkSpeed + barkPosition);
      curveVertex(252, 298 + barkSpeed + barkPosition);
      curveVertex(258, 291 + barkSpeed + barkPosition);
      curveVertex(266, 298 + barkSpeed + barkPosition);
      curveVertex(268, 290 + barkSpeed + barkPosition);
  
      curveVertex(182, 285 + barkSpeed + barkPosition);
    endShape();
  
    resetMatrix();
  
    fill (color(204, 0, 0));
    beginShape();
      curveVertex(200, 315 + barkSpeed + barkPosition);
      curveVertex(221, 315 + barkPosition);
      curveVertex(242, 315 + barkSpeed + barkPosition);
      curveVertex(200, 315 + barkSpeed + barkPosition);
      curveVertex(221, 315 + barkPosition);
      curveVertex(242, 315 + barkSpeed + barkPosition);
    endShape();
  }
}

// Let's go for a walk! (waves its tail), doesn't walk though...
// rotate tail around (300, 393)
void moveWalk(boolean walk) {
  if (buttonWalk) { 
    if (rotateControlW) { // moves upward
      rotateAngleW -= 3; // can change a speed of rotation
     
       if (rotateAngleW <= -30) {
         rotateControlW = false;
       } 
    }
    else { // moves downward
      rotateAngleW += 3; // can change a speed of rotation
      
      if (rotateAngleW >= 0) {
        rotateAngleW = 0;
        rotateControlW = true;
        rotateCountW ++;
      
        if (rotateCountW == 10) { // change here to set rotate num
          rotateCountW = 0;
          buttonWalk = false;
        }
      }
    }
  } 
}

// Let's eat food!!
void foodMotion() {
    
  if (foodControl) {
    if (facePositionY < 70) {
      facePositionY += 3;
    }
    else { // change here to set position
      waitCountF++;
      barkPosition = facePositionY * 0.9 + 10;
      foodLevel += 0.2; // need altered 
      moveBark(true);
      drawFood();

      if (waitCountF == waitFrameF) { // ends eating
        foodControl = false;
        barkPosition = 0;
        waitCountF = 0;
        
        // intialize bark variables
        barkSpeed = 0; 
        barkControl = true;
        barkCount = 0;
      }
    }
  }
  else {
    if (facePositionY != 0) { // brings face back to the original position
      facePositionY -= 2;
    }
    else { // initialize
      waitCountF++;
      
      if (isButtonBarkPressed == false) { // press imaginary bark button
        buttonBark = true;
        isButtonBarkPressed = true;
      }
      
      if (waitCountF == 80) {
        facePositionY = 0;
        foodControl = true;
        buttonFood = false;
        barkPosition = 0;
        foodLevel = 0;
        startEating = false;
        waitCountF = 0;
        
        // intialize bark variables
        barkSpeed = 0; 
        barkControl = true;
        barkCount = 0;
        
        // intialize walk variables
        rotateAngleW = 0;
        rotateControlW = true;
        rotateCountW = 0;
      }
      
    }
  }
}

// eating motion (bark + wave => eat)

void moveFood(boolean food) {
  if (food) {
    drawDish();
    drawFood();
    if (startEating == false) {
      if (rotateCountW != 9) { // while its waving its tail
        
        if (isButtonWalkPressed == false) { // press imaginary walk button
          buttonWalk = true;
          isButtonWalkPressed = true;
        }
        
        if (rotateCountW > 4) { // starts barking here
          if (isButtonBarkPressed == false) { // press imaginary bark button
            buttonBark = true;
            isButtonBarkPressed = true;
          }
        }
        
      }
      else { // done waving
        startEating = true;
        isButtonWalkPressed = false;
        isButtonBarkPressed = false;
        buttonBark = false;
        buttonWalk = false;
  
      }
    }
    else { // start eating
      foodMotion();
    }
  }
}

// hand! Ote!!! remain unwritten
void moveHand() {
  
}

// Couldn't understand our words
void moveQuestion(boolean question) {
  if (nonCapisco) {
    if (rotateControlQ) {
      if (rotateAngleQ > -30) {
        rotateAngleQ -= 1; // can change speed of rotation
      }
      else { // wait
        waitCount ++;
        if (waitCount == waitFrame) { 
          rotateControlQ = false;
        }
      }
    }
    else {
      rotateAngleQ += 1; // can change speed of rotation
      
      if (rotateAngleQ >= 0) { // reset variables
        rotateControlQ = true;
        rotateAngleQ = 0; 
        waitCount = 0;
        nonCapisco = false;
      }
    }
  }
}

// makes buttons for changing color
void colorButton() {
  strokeWeight(1.3);
  
  fill(155, 167, 226, 140);
  beginShape(); // outer shell
    vertex(20, 20);
    bezierVertex(10, 20, 10, 20, 10, 30);
    vertex(10, 80);
    bezierVertex(10, 90, 10, 90, 20, 90);
    vertex(380, 90);
    bezierVertex(390, 90, 390, 90, 390, 80);
    vertex(390, 30);
    bezierVertex(390, 20, 390, 20, 380, 20);
    vertex(20, 20);
  endShape();
  
  fill(255);
  rect(21, 6, 193, 33); // textbox
  
  textSize(32);
  fill(0, 0, 0);
  text("Select Color", 25, 34);
  
  for (int i = 0; i < bodyColors.length; i++) {
    fill(bodyColors[i]);
    rect(30 + 40 * i, 50, 30, 30);
  }
}

// Change color
void colorTransform() {
  
  if (mouseY >= 51 && mouseY <= 81) {
    if (mouseX >= 30 && mouseX <= 60) { // first box
      bodyColor = bodyColors[0];
    }
    else if (mouseX >= 70 && mouseX <= 100) { // second box
      bodyColor = bodyColors[1];
    }
    else if (mouseX >= 110 && mouseX <= 140) { // third box
      bodyColor = bodyColors[2];
    }
    else if (mouseX >= 150 && mouseX <= 180) { // fourth box
      bodyColor = bodyColors[3];
    }
    else if (mouseX >= 190 && mouseX <= 220) { // fifth box
      bodyColor = bodyColors[4];
    }
    else if (mouseX >= 230 && mouseX <= 260) { // sixth box
      bodyColor = bodyColors[5];
    }
    else if (mouseX >= 270 && mouseX <= 300) { // seventh box
      bodyColor = bodyColors[6];
    }
    else if (mouseX >= 310 && mouseX <= 340) { // eighth box
      bodyColor = bodyColors[7];
    }
    else if (mouseX >= 350 && mouseX <= 380) { // ninth box
      bodyColor = bodyColors[8];
    }
  }
}

// creates a button
// abandoned because it is unnecessary
/*
void createButton(int x, int y, int l, int w, color col, String name) {
  fill(col);
  rect(x, y, l, w);
  
  textSize(int(float(l) * 0.9));
  text(name, int());
}
*/

// creates buttons
// memo (10, 500) => 
void createMultipleButtons() {
  fill(155, 167, 226);
  
  strokeWeight(1.3);
  beginShape(); // outer shell
    vertex(20, 490);
    bezierVertex(10, 490, 10, 490, 10, 500);
    vertex(10, 630);
    bezierVertex(10, 640, 10, 640, 20, 640);
    vertex(380, 640);
    bezierVertex(390, 640, 390, 640, 390, 630);
    vertex(390, 500);
    bezierVertex(390, 490, 390, 490, 380, 490);
    vertex(20, 490);
  endShape();
  
  fill(239, 117, 188, 240);
  rect(20, 500, 175, 60); // LT button
  rect(20, 570, 175, 60); // LB button
  rect(205, 500, 175, 60); // RT button
  rect(205, 570, 175, 60); // RB button
  strokeWeight(1);
  
  fill(127, 76, 114);
  textSize(30);
  text("BARK!!", 60, 540);
  text("WALK!!", 240, 540);
  text("BLABLABLA", 25, 610);
  text("FOOD!!", 240, 610);
}

// controls button. doesnt react while one button is pressed
void buttonControl() {
  if (!isButtonPressed()) {
    if (mouseX >= 20 && mouseX <= 195) {
      if (mouseY >= 500 && mouseY <= 560) {
        buttonBark = true;
      }
      else if (mouseY >= 570 && mouseY <= 630) {
        nonCapisco = true;
      }
    }
    else if (mouseX >= 205 && mouseX <= 380) {
      if (mouseY >= 500 && mouseY <= 560) {
        buttonWalk = true;
      }
      else if (mouseY >= 500 && mouseY <= 630) {
        buttonFood = true;
      }
    }
  }
}

// neglects user input when a button is pressed (exclude color change)
boolean isButtonPressed() {
  return buttonBark || buttonWalk || buttonFood || buttonHand || nonCapisco;
}

// for test 
void test () {
  println(mouseX + ", " + mouseY);
}
