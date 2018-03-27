import React, { Component } from 'react';
import PropTypes from "prop-types";

import Fuse from 'fuse.js';
import cache from 'memory-cache';

import enhanceWithClickOutside from 'react-click-outside';
import Loader from 'react-loader-spinner';
// import deepEqual from 'deep-equal';

import './SearchInput.css';
import Highlighter from "./Highlighter";

/*
 * SelectedItem
 *
 * {
 *   value: 2,
 *   text: 'Item 2'
 * }
 *
 * options = [] || function(searchTerm)
 */
class SearchInput extends Component {
    constructor(props) {
        super(props);

        this.state = {
            selectedOption: null,
            text: "",
            showSearch: false,
            activeOptionIndex: -1,
            searchResults: [],
            searching: 0,
            displayingSelectedText: true
        };

        // this.originalValue = this.props.value;
        //this.originalValue = this.props.value;

        this.type = this.props.type;
        if (this.type === "text") {
            this.selectMode = false;
            throw new Error("Text mode is not yet supported");
        } else if (this.type === "select") {
            this.selectMode = true;
        } else {
            throw new Error("Invalid type: '" + this.type + "'");
        }
        this.options = this.props.options;
        this.queryOptions = this.props.queryOptions;

        this.searchResultsCache = new cache.Cache();

        this.handleChange = this.handleChange.bind(this);
        this.handleBlur = this.handleBlur.bind(this);
        this.handleClickOutside = this.handleClickOutside.bind(this);
        this.handleOnClickOption = this.handleOnClickOption.bind(this);
        this.handleKeyDown = this.handleKeyDown.bind(this);
        this.filterOptions = this.filterOptions.bind(this);
        this.getOptionText = this.getOptionText.bind(this);
        this.doSearch = this.doSearch.bind(this);
        this.beginSearch = this.beginSearch.bind(this);
    }

    componentWillMount() {
    }

    componentWillUnmount() {
    }

    // static getOptionValue(option) {
    //     if (typeof option === 'undefined' || option === null) {
    //         return option;
    //     } else if (typeof option.value === 'function') {
    //         return option.value();
    //     } else {
    //         return option.value;
    //     }
    // }

    getOptionText(option, defaultValue) {
        if (typeof option === 'undefined' || option === null) {
            return defaultValue;
        } else {
            const text = option[this.props.textProperty];
            return (typeof text === 'undefined' || text === null) ? defaultValue : text;
        }
    }

    getOptionValue(option, defaultValue) {
        if (typeof option === 'undefined' || option === null) {
            return defaultValue;
        } else {
            const value = option[this.props.valueProperty];
            return (typeof value === 'undefined' || value === null) ? defaultValue : value;
        }
    }

    fuseFilter(items, query, showAllByDefault) {

        let searchKeys = this.props.searchKeys;

        if (typeof searchKeys === 'string') {
            searchKeys = [searchKeys];
        }

        const fuseOptions = {
            caseSensitive: false,
            shouldSort: true,
            tokenize: true,
            matchAllTokens: true,
            includeScore: true,
            includeMatches: true,
            threshold: 0.2,
            location: 0,
            distance: 100,
            maxPatternLength: 32,
            minMatchCharLength: 1,
            keys: searchKeys
        };
        // console.log("Fuse search for '" + query + "'", items, fuseOptions);
        const fuse = new Fuse(items, fuseOptions);
        const results = fuse.search(query);

        const count = results.length;

        // console.log("Fuse search results: " + count, results);

        // const resultItems = [];
        // for (let i = 0; i < count; i++) {
        //     const result = results[i];
        //     resultItems.push(result.item);
        // }


        return results;
    }

    // static simpleFilter(options, query, showAllByDefault, filterFunc) {
    //
    //     if (typeof options === 'undefined' || options === null || !options) {
    //         return [];
    //     }
    //
    //     const query_lc = (typeof query !== 'undefined' && query !== null) ? query.trim().toLowerCase() : "";
    //     const hasQuery = query_lc.length > 0;
    //
    //     if (typeof filterFunc === 'undefined') {
    //         filterFunc = "includes";
    //     }
    //
    //     if (typeof filterFunc === 'string') {
    //         const stringFuncName = filterFunc;
    //         filterFunc = (option) => {
    //             const optionText = SearchInput.getOptionText(option);
    //             return (typeof optionText !== 'undefined' && optionText !== null)
    //                 ? optionText.trim().toLowerCase()[stringFuncName](query_lc)
    //                 : false;
    //
    //         };
    //     }
    //
    //     const filtered = [];
    //     for (let i = 0; i < options.length; i++) {
    //         const option = options[i];
    //         let match;
    //         if (hasQuery) {
    //             match = filterFunc(option, query_lc);
    //         } else {
    //             match = showAllByDefault;
    //         }
    //         if (match) {
    //             filtered.push(option);
    //         }
    //     }
    //     return filtered;
    // }

    filterOptions(options, query, showAllByDefault) {
        return this.fuseFilter(options, query, showAllByDefault);
    }

    /**
     *  'options' can be:
     * 1. an array of options or
     * 2. a Promise resolving to array of options
     * 3. function providing ...
     *   3a) an array of options or
     *   3b) a Promise resolving to array of options
     *
     * Only case 3 supports queries.
     *
     * @param options
     * @param query
     * @param showAllByDefault
     * @param resultsCache an optional cache for results, must have methods get(key) and put(key, value)
     * @param filter the filter to be applied if the options doesn't support queries (cases 1 and 2)
     * @returns {*}
     */
    static toOptionsPromise(options, query, showAllByDefault, resultsCache, filter) {

        // We always return Promise

        // 'options' can be:
        // 0. null or undefined, in which case the returned promise resolves to empty results
        // 1. an array of options or
        // 2. a Promise resolving to array of options (can't query)
        // 3. function providing ...
        //   3a) an array of options or
        //   3b) a Promise resolving to array of options
        //
        // Query parameters are sent to 3

        // From cache?
        const cachedResults = (typeof resultsCache !== 'undefined' && resultsCache !== null)
            ? resultsCache.get(query) : null;


        const fromCache = (typeof cachedResults !== 'undefined' && cachedResults !== null);

        if (typeof options === 'undefined' || options === null) {
            return new Promise((resolve) => resolve([]));
        }

        // Add internal filtering if options is array
        let promise = null;

        if (fromCache) {
            // console.log("Found search results from cache: " + query, cachedResults);
            promise = new Promise((resolve) => {
                resolve(cachedResults);
            });
        } else if (typeof options === 'object') {

            if (Array.isArray(options)) {
                // 1. an array of options or
                // console.log("options is an array", options);
                promise = new Promise((resolve, reject) => {
                    resolve(options);
                });
            } else if (typeof options.then === 'function') {
                // 2. a Promise resolving to array of options
                // console.log("options is a Promise");
                promise = options;
            }
        } else if (typeof options === 'function') {
            // 3. function providing...
            // console.log("options is a function");

            // Call the function with query
            const result = options(query);

            if (typeof result === 'undefined' || result === null) {
                console.error("Got undefined or null options from options function");
                promise = null;
            } else if (typeof result === 'object') {
                if (Array.isArray(result)) {
                    // 3a) an array of options
                    // console.log("options function returns an array");

                    promise = new Promise((resolve, reject) => {
                        resolve(result);
                    });
                } else if (typeof result.then === 'function') {
                    // 3b) a Promise resolving to array of options
                    // console.log("options function returns a Promise");
                    promise = result;
                } else {
                    console.error("options function returned an object of unsupported type: " + result.constructor.name, result);
                }
            } else {
                console.error("Unsupported return value from options function", result);
            }
        }

        if (typeof(promise) === 'undefined' || promise === null) {
            console.error("Don't know how to extract options from " + (typeof options));
            return new Promise((resolve, reject) => {
                reject("Options not available");
            });
        }


        if (!fromCache && typeof resultsCache !== 'undefined' && resultsCache !== null) {
            promise = promise.then((results) => {
                // console.log("Storing search results to cache: " + query, results);
                resultsCache.put(query, results);
                return results;
            });
        }

        if (typeof filter !== 'undefined' && filter !== null) {
            return promise.then((results) => {
                return filter(results, query, showAllByDefault);
            });
        } else {
            return promise;
        }
    }

    static cacheKey(query) {
        if (typeof query === 'undefined' || query === null) {
            return "";
        } else {
            return query;
        }
    }

    getSearchResultsFromCache(query) {
        if (!this.props.useCache) {
            return null;
        }
        const key = SearchInput.cacheKey(query);
        return this.searchResultsCache.get(key);
    }
    putSearchResultsToCache(query, searchResults) {
        if (!this.props.useCache) {
            return null;
        }
        const key = SearchInput.cacheKey(query);
        let ttl = this.props.cacheTimeout; // ms
        if (typeof ttl === 'undefined' || !ttl) {
            ttl = 60000; // TODO use constant
        }
        return this.searchResultsCache.put(key, searchResults, ttl, (k, v) => {
            // console.log("Cached search results expired :" + k);
        });
    }


    handleChange(event) {
        // console.log("HandleChange", event);

        let text = event.target.value;

        const selectedText = (typeof this.state.selectedOption !== 'undefined' && this.state.selectedOption !== null)
            ? this.getOptionText(this.state.selectedOption) : "";


        this.setState({
            text: text,
            displayingSelectedText: (text === selectedText)
        });

        this.beginSearch(text);

    }

    beginSearch(query) {

        this.setState({
            showSearch: true,
            searching: this.state.searching + 1
        });



        this.doSearch(query).then((searchResults) => {
            if (this.state.text === query) {
                // query not changed since, apply these results
                this.setState({
                    searchResults: searchResults,
                    searching: this.state.searching - 1,
                    activeOptionIndex: -1
                });
            } else {
                // Query changed since we initiated the search, don't use these results
                this.setState({
                    searching: this.state.searching - 1
                });
            }
            return searchResults;
        });

    }


    doSearch(query) {

        if (typeof query === 'undefined' || query === null) {
            query = "";
        }
        query = query.trim();


        let promise;
        if (typeof this.queryOptions !== 'undefined' && this.queryOptions !== null) {
            // With backend query:
            promise = SearchInput.toOptionsPromise(
                this.queryOptions,
                query,
                false,
                {
                    get: (k) => { return this.getSearchResultsFromCache("_queryOptions_" + k) },
                    put: (k, v) => { return this.putSearchResultsToCache("_queryOptions_" + k, v) }
                },
                undefined);
        } else {
            // With internal filtering
            promise = SearchInput.toOptionsPromise(
                this.options,
                query,
                false,
                {
                    get: () => { return this.getSearchResultsFromCache("_options") },
                    put: (k, v) => { return this.putSearchResultsToCache("_options", v) }
                },
                this.filterOptions);
        }

        return promise;

    }


    handleBlur(event) {

        // console.log("handleBlur: " + this.preventBlur, event, event.target);
        if (this.preventBlur) {
            event.stopPropagation();
            event.preventDefault();
            return;
        }

        this.handleClickOutside();

    }
    handleClickOutside() {

        // Does the text match the current selection?
        const currentText = this.state.text;
        const selectedText = this.getOptionText(this.state.selectedOption, "");
        if (currentText === selectedText) {
            this.setState({
                text: selectedText,
                displayingSelectedText: true,
                showSearch: false,
                activeOptionIndex: -1
            });
        } else {
            // Perform search
            this.setState({
                displayingSelectedText: false,
                showSearch: false,
                searching: this.state.searching + 1
            });
            this.doSearch(currentText).then((searchResults) => {

                let foundMatch = false;
                if (this.state.text === currentText) {
                    // Text changed since we initiated the search
                    const perfectMatch = this.selectPerfectSearchMatch(searchResults);

                    if (perfectMatch != null) {
                        // only 1 result available and its score is 0
                        this.selectOption(perfectMatch.item);
                        foundMatch = true;
                    }

                }

                if (!foundMatch && this.state.text === currentText) {
                    // Restore selected value
                    this.setState({
                        displayingSelectedText: false,
                        text: selectedText
                    });
                }


                this.setState({

                    searching: this.state.searching - 1
                });
            });
        }


    }


    handleKeyDown(event) {
        // console.log("handleKeyDown:" + event.key, event);

        const currentActiveIndex = this.state.activeOptionIndex;
        let searchResults = this.state.searchResults;
        if (typeof searchResults === 'undefined' || searchResults === null) {
            searchResults = [];
        }



        if (this.state.showSearch) {

            const maxIndex = searchResults.length - 1;
            switch (event.key) {
                case 'ArrowUp':
                    if (currentActiveIndex >= 0) {
                        this.setState({
                            activeOptionIndex: currentActiveIndex - 1
                        });
                    }
                    break;

                case 'ArrowDown':
                    if (currentActiveIndex < maxIndex) {
                        this.setState({
                            activeOptionIndex: currentActiveIndex + 1
                        });
                    }
                    break;

                case 'Enter':
                    // Use the selected item
                    // - the currently selected (active) option OR
                    // - there is one search result available with score 0.0 (= perfect match)

                    if (currentActiveIndex >= 0 && currentActiveIndex <= maxIndex) {
                        this.selectOption(searchResults[currentActiveIndex].item);
                    } else if (currentActiveIndex < 0) {
                        // No selection.
                        const perfectMatch = this.selectPerfectSearchMatch(searchResults);

                        if (perfectMatch != null) {
                            // only 1 result available and its score is 0
                            this.selectOption(perfectMatch.item);
                        }
                    }
                    break;
            }
        }

    }

    selectPerfectSearchMatch(searchResults) {
        if (typeof searchResults === 'undefined' || searchResults === null) {
            return null;
        }

        let perfectMatch = null;
        for (let i = 0; i < searchResults.length; i++) {
            if (searchResults[i].score === 0.0) {
                // Perfect match
                if (perfectMatch != null) {
                    // Already found another, nullify and quit because we need to
                    // have only one perfect match!
                    perfectMatch = null;
                    break;
                }
                perfectMatch = searchResults[i];
                // keep on going because we need to find out if there are other perfect
                // matches available
            }
        }
        return perfectMatch;
    }

    selectOption(option) {

        const currentValue = this.getOptionValue(this.state.selectedOption);
        const newValue = this.getOptionValue(option);

        const changed = currentValue !== newValue;

        this.setState({
            selectedOption: option,
            text: this.getOptionText(option),
            displayingSelectedText: true,
            showSearch: false,
            activeOptionIndex: -1,
            searchResults: []
        });

        if (changed && typeof this.props.onOptionSelected === 'function') {
            this.props.onOptionSelected(option, newValue, currentValue);
        }

        this.outerWrapper.focus();
    }

    handleOnClickOption(option, event) {
        // console.log("handleOnClickOption", option, event);
        this.selectOption(option);
    }


    render() {

        const searchResults = (typeof this.state.searchResults !== 'undefined' && this.state.searchResults !== null)
            ? this.state.searchResults : [];

        const renderOptions = () => {
            const components = [];

            if (this.state.searching > 0) {
                components.push(
                    <div key={-1} className={"loading"}>
                        <Loader type={"ThreeDots"} height={searchResults.length > 0 ? "0.5em" : "2em"} color={"silver"}/>
                    </div>
                );
            }
            if (typeof searchResults !== 'undefined' && searchResults !== null) {
                for (let i = 0; i < searchResults.length; i++) {
                    const searchResult = searchResults[i];
                    const option = searchResult.item;
                    let optionClassName = "dropdown-item";
                    if (this.state.activeOptionIndex === i) {
                        optionClassName += " active";
                    }

                    optionClassName += " search-result";

                    let searchKeys = this.props.searchKeys;
                    if (typeof searchKeys === 'string') {
                        searchKeys = [searchKeys];
                    }

                    const itemMarkup = Highlighter.createResultMarkup(searchResult, searchKeys);
                    const optionTextMarkup = this.getOptionText(itemMarkup);

                    const score = searchResult.score;
                    if (typeof score !== 'undefined' && score !== null) {
                        let appendClassSuffix = "";

                        if (score >= 0.9) {
                            // Poor 0.9...
                            appendClassSuffix = "poor";
                        } else if (score >= 0.6) {
                            // Average 0.5 .. 0.9
                            appendClassSuffix = "average";
                        } else if (score >= 0.4) {
                            // Good 0.4 .. 0.5
                            appendClassSuffix = "good";
                        } else if (score >= 0.2) {
                            // Very good 0.2 .. 0.4
                            appendClassSuffix = "very-good";
                        } else if (score >= 0.1) {
                            // Excellent 0.1 .. 0.2
                            appendClassSuffix = "excellent";
                        } else if (score >= 0) {
                            // Perfect 0 .. 0.1
                            appendClassSuffix = "perfect";
                        } else {
                            // Unknown
                            appendClassSuffix = "";
                        }

                        if (appendClassSuffix.length > 0) {
                            optionClassName += (" search-match-" + appendClassSuffix);
                        }
                    }

                    components.push(
                        <a key={i} className={optionClassName}
                           onClick={(e) => this.handleOnClickOption(option, e)}
                           onMouseDown={() => this.preventBlur = true}
                           onMouseUp={() => this.preventBlur = false}
                           dangerouslySetInnerHTML={{__html: optionTextMarkup}}/>
                    );
                }
            }
            return components;
        };

        const renderDropdown = () => {
            if (!this.state.showSearch) {
                return null;
            }
            const items = renderOptions();

            if (items.length > 0) {
                return (
                    <div className={"dropdown" + (searchResults.length > 0 ? " has-items" : "")}>
                        <div className={"dropdown-menu show"}>
                            {renderOptions()}
                        </div>
                    </div>
                );
            } else {
                return null;
            }
        };


        let inputClassName = "form-control";
        if (!this.state.displayingSelectedText) {
            inputClassName += " search-term";
        }

        const selectedValue = this.getOptionValue(this.state.selectedOption, "");
        return(
            <div ref={(div) => {this.outerWrapper = div;}} className={"SearchInput"}>
                <input name={this.props.name} type={"hidden"} value={selectedValue}/>
                <div className={""}>
                    {/*<pre>{JSON.stringify(this.state.selectedOption)}</pre>*/}
                    <div className={"input-group"}>
                        <input
                            name={this.props.name + "-text"}
                            className={inputClassName}
                            type={"text"}
                            onChange={this.handleChange}
                            onKeyDown={this.handleKeyDown}
                            onBlur={this.handleBlur}
                            value={this.state.text}>
                        </input>
                        {
                            (this.state.searching > 0) &&
                            <div className={"input-group-append loading"}>
                                <Loader type={"ThreeDots"} height={"2em"} width={"2em"} color={"silver"}/>
                            </div>
                        }

                    </div>
                </div>
                {renderDropdown()}

            </div>
        );

    }
}
SearchInput.propTypes = {
    value: PropTypes.string,
    type: PropTypes.oneOf(["text", "select"]),

    options: PropTypes.oneOfType([
        PropTypes.arrayOf(PropTypes.shape({
            value: PropTypes.any,
            text: PropTypes.string
        })),
        PropTypes.object,
        PropTypes.func
    ]),
    // Supports case 3 from 'options', function is called with query and results
    // are not filtered any further. Please note that this function must result
    // results using the fuse.js search results shape
    queryOptions: PropTypes.func,

    valueProperty: PropTypes.string,
    textProperty: PropTypes.string,

    searchKeys: PropTypes.oneOfType([
        PropTypes.string,
        PropTypes.arrayOf(PropTypes.string)
    ]),
    useCache: PropTypes.bool,
    cacheTimeout: PropTypes.number,

    onOptionSelected: PropTypes.func
};

SearchInput.defaultProps = {
    valueProperty: "value",
    textProperty: "text",
    searchKeys: ["text"],
    useCache: true,
    cacheTimeout: 60000

};

SearchInput.contextTypes = {

};

export default enhanceWithClickOutside(SearchInput);