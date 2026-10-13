const fs=require('fs'),p=require('path');
fs.rmSync('www',{recursive:true,force:true});fs.mkdirSync('www',{recursive:true});
for(const f of ['index.html','config.js','manifest.webmanifest','icons','mascots'])if(fs.existsSync(f))fs.cpSync(f,p.join('www',f),{recursive:true});
console.log('www ready');
