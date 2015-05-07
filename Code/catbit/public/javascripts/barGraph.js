//Code from: http://www.williammalone.com/articles/html5-canvas-javascript-bar-graph/

function BarGraph(ctx) {

  // Private properties and methods
  
  var that = this;
  var startArr;
  var endArr;
  var looping = false;
  
  // Loop method adjusts the height of bar and redraws if necessary
  var loop = function() {
    var delta;
    var animationComplete = true;

    // Boolean to prevent update function from looping if already looping
    looping = true;
    
    // For each bar
    for (var i = 0; i < endArr.length; i += 1) {
      // Change the current bar height toward its target height
      delta = (endArr[i] - startArr[i]) / that.animationSteps;
      that.curArr[i] += delta;
      // If any change is made then flip a switch
      if (delta) {
        animationComplete = false;
      }
    }
    
    // If no change was made to any bars then we are done
    if (animationComplete) {
      looping = false;
    } else {
      // Draw and call loop again
      draw(that.curArr);
      setTimeout(loop, that.animationInterval / that.animationSteps);
    }
  }; // End loop function
  
  // Draw method updates the canvas with the current display
  var draw = function(arr) {
    var numOfBars = arr.length;
    var barWidth;
    var barHeight;
    var border = 0;
    var ratio;
    var maxBarHeight;
    var gradient;
    var largestValue;
    var graphAreaX = 0;
    var graphAreaY = 0;
    var graphAreaWidth = that.width;
    var graphAreaHeight = that.height;
    var i;
    
    // Update the dimensions of the canvas only if they have changed
    if (ctx.canvas.width !== that.width || ctx.canvas.height !== that.height) {
      ctx.canvas.width = that.width;
      ctx.canvas.height = that.height;
    }
        
    // Draw the background color ---- I made this tranparent
    ctx.fillStyle = that.backgroundColor;
    ctx.fillRect(0, 0, that.width, that.height);
          
    // If x axis labels exist then make room	
    if (that.xAxisLabelArr.length) {
      graphAreaHeight -= 40;
    }
        
    // Calculate dimensions of the bar
    barWidth = graphAreaWidth / numOfBars - that.margin * 2;
    maxBarHeight = graphAreaHeight - 25;
        
    // Determine the largest value in the bar array
    var largestValue = 0;
    for (i = 0; i < arr.length; i += 1) {
      if (arr[i] > largestValue) {
        largestValue = arr[i];	
      }
    }
    
    // For each bar
    for (i = 0; i < arr.length; i += 1) {
      // Set the ratio of current bar compared to the maximum
      if (that.maxValue) {
        ratio = arr[i] / that.maxValue;
      } else {
        ratio = arr[i] / largestValue;
      }
      
      barHeight = ratio * maxBarHeight;
      
      /*
      // Turn on shadow
      ctx.shadowOffsetX = 2;
      ctx.shadowOffsetY = 2;
      ctx.shadowBlur = 2;
      ctx.shadowColor = "#999";
      */
			
        
      // Draw bar background
      ctx.fillStyle = "white";	//changed to white		
      ctx.fillRect(that.margin + i * that.width / numOfBars,
        graphAreaHeight - barHeight,
        barWidth,
        barHeight);
		
      /*
      // Turn off shadow
      ctx.shadowOffsetX = 0;
      ctx.shadowOffsetY = 0;
      ctx.shadowBlur = 0;
      */
    
      /*
      // Create gradient
      gradient = ctx.createLinearGradient(0, 0, 0, graphAreaHeight);
      gradient.addColorStop(1-ratio, that.colors[i % that.colors.length]);
      gradient.addColorStop(1, "#ffffff");
    
      ctx.fillStyle = gradient;
      // Fill rectangle with gradient
      ctx.fillRect(that.margin + i * that.width / numOfBars + border,
        graphAreaHeight - barHeight + border,
        barWidth - border * 2,
        barHeight - border * 2);
      */
      
      // No Gradient, solid white
      ctx.fillStyle = "white";
      ctx.fillRect(that.margin + i * that.width / numOfBars + border,
        graphAreaHeight - barHeight + border,
        barWidth - border * 2,
        barHeight - border * 2);
      
      
      // Write bar value
      ctx.fillStyle = "white";
      ctx.font = "bold 15px Lucida Sans Unicode";
      ctx.textAlign = "center";
      // Use try / catch to stop IE 8 from going to error town
      try {
        ctx.fillText(parseInt(arr[i],10),
          i * that.width / numOfBars + (that.width / numOfBars) / 2,
          graphAreaHeight - barHeight - 10);
      } catch (ex) {}
      
      
      // Draw bar label if it exists
      if (that.xAxisLabelArr[i]) {				
        // Use try / catch to stop IE 8 from going to error town				
        ctx.fillStyle = "white";
        ctx.font = "bold 15px Lucida Sans Unicode";
        ctx.textAlign = "center";
        try {
          ctx.fillText(that.xAxisLabelArr[i],
            i * that.width / numOfBars + (that.width / numOfBars) / 2,
            that.height - 10);
        } catch (ex) {}
      }
    }
  }; // End draw method
  
  // Public properties and methods
	
  this.width = 300;
  this.height = 150;	
  this.maxValue;
  this.margin = 5;
  this.colors = ["purple", "red", "green", "yellow"];
  this.curArr = [];
  this.backgroundColor = "rgba(0,0,0,0)"; //#55da9a;
  this.xAxisLabelArr = [];
  this.yAxisLabelArr = [];
  this.animationInterval = 100;
  this.animationSteps = 10;
	
  // Update method sets the end bar array and starts the animation
  this.update = function (newArr) {
  
    // If length of target and current array is different 
    if (that.curArr.length !== newArr.length) {
      that.curArr = newArr;
      draw(newArr);
    } else {
      // Set the starting array to the current array
      startArr = that.curArr;
      // Set the target array to the new array
      endArr = newArr;
      // Animate from the start array to the end array
      if (!looping) {	
        loop();
      }
    }
  
  }; // End update method
}