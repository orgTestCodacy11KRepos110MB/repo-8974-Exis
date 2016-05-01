module.exports = {};
var exp = module.exports;
var Q = require('q');

var registrar = 'https://node.exis.io:8880';
exp.setRegistrar = function(url){
  registrar = url;
}

exp.loginAnonymous = function(){
  var p = Q.defer();
  getToken({domain: "", password: "", requestingdomain: this.getName()}, p, this);
  return p.promise;
};

exp.loginUsernameOnly = function(user){
  var p = Q.defer();
  getToken({domain: user.username, password: "", requestingdomain: this.getName()}, p, this);
  return p.promise;
};

exp.login = function(user){
  var p = Q.defer();
  getToken({domain: user.username || '', password: user.password || '', requestingdomain: this.getName()}, p, this);
  return p.promise;
};

exp.registerAccount = function(user){
  var p = Q.defer();
  register({"domain": user.username, "domain-password": user.password, "domain-email": user.email, "Name": user.name, "requestingdomain": this.getName()}, p, this);
  return p.promise;
};

exp.uploadFile = function(file, correct, url){
  var p = Q.defer();
  putObject(file, correct, url, p);
  return p.promise;
};


function getToken(body, promise, conn){

  if(XMLHttpRequest === undefined){
    promise.reject('Error: XMLHttpRequest not found.');
  }else{
    var http = new XMLHttpRequest();
    http.addEventListener("error", error);
    http.addEventListener("load", complete);
    http.open('POST', registrar + '/login');
    http.send(JSON.stringify(body));
    function error(err){
      promise.reject(err);
    }   
    function  complete(resp){
      if(http.status == 200){
        body = JSON.parse(http.responseText);
        var d = conn.linkDomain(body.domain);
        d.setToken(body.login_token);
        promise.resolve(d);
      }else{
        promise.reject(body);
      }   
    }   
  } 
}

function register(body, promise, conn){

  if(XMLHttpRequest === undefined){
    promise.reject('Error: XMLHttpRequest not found.');
  }else{
    var http = new XMLHttpRequest();
    http.addEventListener("error", error);
    http.addEventListener("load", complete);
    http.open('POST', registrar + '/register');
    http.send(JSON.stringify(body));
    function error(err){
      promise.reject(err);
    }   
    function  complete(resp){
      if(http.status == 200){
        promise.resolve("Successful Registration.");
      }else{
        promise.reject(body);
      }   
    }   
  } 
}

function putObject(file, correct, url, promise){

  if(correct){
    correctOrientation(file, upload);
  }else{
    upload(file);
  }

  function upload(blob){
    if(XMLHttpRequest === undefined){
      promise.reject('Error: XMLHttpRequest not found.');
    }else{
      var http = new XMLHttpRequest();
      http.addEventListener("error", bad);
      http.addEventListener("load", complete);
      http.addEventListener("progress", progress);
      if( http.upload ){
        http.upload.onprogress = progress
      }   
      http.open('PUT', url);
      http.send(blob);
      function bad(err){
        promise.reject(err);
      }   
      function progress(res){
        promise.notify(((res.loaded / res.total) * 100));
      }   
      function  complete(resp){
        if(http.status ==200){
          promise.resolve("File Uploaded.");
        }else{
          promise.reject("Error: ", http.responseText);
        }   
      }   
    }
  }
}

var correctOrientation = function(file, callback){
  if(file.type.match(/^image\//)){
    try{
      EXIF.getData(file, function() {
        try{
          var exif = EXIF.getTag(this, 'Orientation');
          if(Number.isInteger(exif) && exif > 1){
            loadImage(
                file,
                function (img) {
                  try{
                    if(img && img.toBlob){
                      img.toBlob(function(blob){
                        callback(blob);
                      }, file.type);
                      return;
                    }
                    callback(file);
                  }catch(e){
                    callback(file);
                  }
                },
                {orientation: exif}
            );
          }else{
            callback(file);
          }
        }catch(e){
          callback(file);
        }
      });
    }catch(e){
      callback(file);
    }
  }else{
    callback(file);
  }
};
