this.storage.getItem('token')
       .then(
           data => {
             return this.http.get(this.env.API_URL + '/api/doctorsListAutoCompleteApi ', {}, {'Authorization': 'Bearer '+ data}).then(res => {
               const results = JSON.parse(res.data);
               this.items =JSON.parse(JSON.stringify(results));
               //console.log("itemss "+this.items);
               return this.items;
             })
                 .catch(error => {
                   console.log(error);
                 });
           },
           error => {console.error(error)}
       );


