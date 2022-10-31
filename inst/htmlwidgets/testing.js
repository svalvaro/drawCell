var sls = 'SL001,SL002';
var colour_sl = 'red';


var coloured_subcell = (sls) => {
    var individual_sls = sls.split(',');
    var htmlColour = '';
    for (let sls_index = 0; sls_index < individual_sls.length; sls_index++) {
        htmlColour = htmlColour +
            `
      svg #${individual_sls[sls_index]} *:not(text) {fill:${colour_sl}}
      svg #${individual_sls[sls_index]} *:not(path, .coloured) {opacity:0.8}
      svg #${individual_sls[sls_index]} .coloured {stroke:black}
      `;
    }
    return (htmlColour);
};
console.log(coloured_subcell(sls));

//console.log(htmlString(sls));

//htmlString(sls);