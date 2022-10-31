HTMLWidgets.widget({

  name: 'drawCell',

  type: 'output',

  factory: function (el, width, height) {

    // TODO: define shared variables for this instance

    return {

      renderValue: function (params) {
        var input_id = params.input_id;
        var taxid = params.organism_identifier;
        var sls = params.sl_ids;
        var colour_sl = params.colour_sl;
        console.log(sls);
        console.log(colour_sl);

        var htmlString = `<template id="sibSwissBioPicsSlLiItem"> <li class="subcellular_location"> <a class="subcell_name"></a> <span class="subcell_description"></span> </li> </template>`

        htmlString += '<template id="sibSwissBioPicsStyle"><style>.terms,.subcell_description,.subcell_name { display:none; }'
        
        var coloured_subcell = (sls) => {
          var individual_sls = sls.split(',');
          var htmlColour = '';
          
          var colours_individual = colour_sl.split(',')
          console.log(colour_sl);
          console.log(colours_individual);
          
          for (let sls_index = 0; sls_index < individual_sls.length; sls_index++) {
            htmlColour = htmlColour +
              `
            svg #${individual_sls[sls_index]} *:not(text) {fill:${colours_individual[sls_index]}}
            svg #${individual_sls[sls_index]} *:not(path, .coloured) {opacity:0.8}
            svg #${individual_sls[sls_index]} .coloured {stroke:black}
            `;
          }
          return (htmlColour);
        };
        console.log(coloured_subcell(sls));
        htmlString += coloured_subcell(sls);
        htmlString += '</style></template>'

        htmlString += `<sib-swissbiopics-sl input_id="${input_id}" taxid="${taxid}" sls="${sls}" contentid="sibSwissBioPicsSlLiItem"></sib-swissbiopics-sl>`

        el.innerHTML = htmlString;
      },

      resize: function (width, height) {

        // TODO: code to re-render the widget with a new size

      }

    };
  }
});
