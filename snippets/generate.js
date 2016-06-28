var fs = require('fs'),
    type = process.argv[2],
    dataFile = './' + type + '-mode.json',
    dist = './' + type + '-mode',
    data;


// check if target JSON file is existing
if (fs.existsSync(dataFile)) {
  data = JSON.parse(fs.readFileSync(dataFile, 'utf-8'));
  generateSnippets(type, data, dist);
} else {
  console.log("Can't find file " + dataFile);
}


function generateSnippets(type, data, dist) {
  // check if snippets folder is already existing
  if (fs.existsSync(dist)) {
    // get rid of existing snippets
    fs.readdirSync(dist).forEach(function(file) {
      fs.unlinkSync(dist + '/' + file);
    });
  } else {
    // create a new folder
    fs.mkdirSync(dist);
  }

  if (type == 'scss') {
    data.forEach(function(entry) {
      var abbrev = entry.abbrev,
          key = abbrev.replace(':', ''),
          content = entry.content,
          filename = abbrev.replace(':', '-');

      var file = '# name: ' + content + '\n' +
          '# key: ' + key + '\n' +
          '# --\n' +
          content;

      fs.writeFileSync(dist + '/' + filename, file);
    });
  } else {
    return false;
  }

  // snippets.forEach(function(entry) {
  //   var name = entry.name,
  //       key = entry.key,
  //       content = entry.content;

  //   var file = '# name: ' + name + '\n' +
  //     '# key: ' + key + '\n' +
  //     '# --\n' +
  //     content;

  //   fs.writeFileSync(dist + '/' + key, file);
  // });

  console.log('Successfully created ' + data.length + ' ' + type + ' snippets.');
}
