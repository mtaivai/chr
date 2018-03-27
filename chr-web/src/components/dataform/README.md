

# DataForm

    DataForm
        DataFormField [0..*]
        DataFormGroup [0..*]
            DataFormField [0..*]


## DataFormGroup

## DataFormField


### Field With a Custom Input Component

    // Bind the 'country' DataFormField to a variable,
    // works like React Ref's.
    const bindCountrySelect = (f) => {
        this.countrySelect = f;
    };

    const handleCountrySelected = (option, value) => {
        this.countrySelect.setValue(value);
    };

Here's a field `country` u

    <DataFormField name={"country"} type={"custom"} label={"Country"}
        bind={bindCountrySelect}>
        <SearchInput
            type="select"
            useCache={true}
            options={() => {
                return countryService.getCountries().then((r) => r.content);
            }}
            onOptionSelected={handleCountrySelected}
            valueProperty={"code"}
            textProperty={"name"}
            searchKeys={["name", "code"]}/>

    </DataFormField>
