import React, { Component } from 'react';

import './TagInput.css';
import PropTypes from "prop-types";
import enhanceWithClickOutside from "react-click-outside";
import Popper from './Popper.js';

// class CoordinateUtils {
//     static pageToElement(pos, elem) {
//
//         if (typeof(pos) === 'undefined' || pos === null) {
//             return pos;
//         }
//         if ((typeof pos.x === 'undefined' || pos.x === null) &&
//             (typeof pos.y === 'undefined' || pos.y === null)) {
//
//             return {};
//         }
//
//         let x = 0;
//         let y = 0;
//
//         if (elem.offsetParent) {
//             do {
//                 x += elem.offsetLeft;
//                 y += elem.offsetTop;
//             } while (elem = elem.offsetParent);
//         }
//
//         const transformed = {};
//         if (typeof pos.x !== 'undefined' && pos.x !== null) {
//             transformed.x = pos.x - x;
//         }
//         if (typeof pos.y !== 'undefined' && pos.y !== null) {
//             transformed.y = pos.y - y;
//         }
//         return transformed;
//     }
// }

// Like select, with child options!
class TagInput extends Component {

    constructor(props) {
        super(props);
        this.state = {
            text: "",
            editMode: false,
            selectedIndices: [],
            dropDownPositionHint: {}
        };
        this.handleInputChange = this.handleInputChange.bind(this);
        this.adjustSearchInputWidth = this.adjustSearchInputWidth.bind(this);
        this.handleContainerClick = this.handleContainerClick.bind(this);
        this.setOptionAtIndexSelected = this.setOptionAtIndexSelected.bind(this);
        this.handleToggleEditMode = this.handleToggleEditMode.bind(this);
        this.handleClickOutside = this.handleClickOutside.bind(this);


        // Merge settings from defaults and props.settings:
        this.settings = {...TagInput.defaultProps.settings};

        Object.assign(this.settings, this.props.settings);

        if (!this.settings.useEditModeButton && this.settings.toggleEditModeOnClick == null) {
            this.settings.toggleEditModeOnClick = true;
        }
        if (!this.settings.toggleEditModeOnClick && this.settings.useEditModeButton == null) {
            this.settings.useEditModeButton = true;
        }

        console.log("Merged settings", this.settings);

        this.options = [];

        if (this.settings.editMode) {
            this.state.editMode = true;
        }
    }

    componentWillMount() {


        let optIndex = 0;
        // If we have <option> children, pick options from those:
        React.Children.forEach(this.props.children, (child) => {
            if (child.type === 'option') {
                this.options.push({
                    value: child.props.value,
                    text: child.props.children
                });
                if (child.props.selected) {
                    this.state.selectedIndices.push(optIndex);
                }
                optIndex++;
            }
        });



    }


    componentDidMount() {

        // Initial justing of input fields
        this.adjustSearchInputWidth();

    }

    componentDidUpdate(prevProps, prevState, prevContext) {
        this.adjustSearchInputWidth();
    }

    handleInputChange(e) {
        this.setState({
            text: e.target.value
        });
    }

    isOptionAtIndexSelected(index) {
        for (let i = 0; i < this.state.selectedIndices.length; i++) {
            if (this.state.selectedIndices[i] === index) {
                return true;
            }
        }
        return false;
    }
    setOptionAtIndexSelected(index, selected, currentSelected) {
        console.log("setOptionAtIndexSelected(" + index + ", " + selected + ")");

        if (currentSelected == null) {
            currentSelected = this.state.selectedIndices;
        }

        if (selected == null) {
            selected = true;
        }

        const newSelArr = [];


        if (this.props.multiple) {
            let wasSelected = false;
            for (let i = 0; i < currentSelected.length; i++) {
                const thisInd = currentSelected[i];
                if (thisInd !== index) {
                    // Not the requested index, leave as selected
                    newSelArr.push(thisInd);
                } else if (selected) {
                    // Was already selected and requested to keep selected
                    wasSelected = true;
                    newSelArr.push(thisInd);
                }
            }
            if (selected && !wasSelected) {
                newSelArr.push(index);
            }
        } else {
            if (selected) {
                newSelArr.push(index);
            }
        }


        this.setState({
            selectedIndices: newSelArr
        });
        console.log("New selection", newSelArr);
        return newSelArr;
    }

    // setOptionWithValueSelected(value, selected) {
    //
    //     console.log("setOptionWithValueSelected(" + value + ", " + selected + ")");
    //     const sels = this.state.selectedIndices;
    //     for (let i = 0; i < sels.length; i++) {
    //         const opt = this.options[i];
    //         if (opt != null && opt.value === value) {
    //             this.setOptionAtIndexSelected(i, selected);
    //         }
    //     }
    // }

    handleToggleEditMode(e) {
        if (!this.settings.editMode) {
            this.toggleEditMode(undefined, {fromToggleButton: true});
        }
        e.preventDefault();
        e.stopPropagation();
    }

    toggleEditMode(editMode, posHint) {
        if (editMode == null) {
            editMode = !this.state.editMode;
        }
        if (this.state.editMode !== editMode) {
            console.log("toggleEditMode " + this.state.editMode + " ==> " + editMode, posHint);
            this.setState({
                editMode: editMode,
                dropDownPositionHint: posHint
            });
        }
    }


    handleContainerClick(e) {
        console.log("handleContainerClick." + e.target.className, e, e.target);

        const allowToggleEditMode = !this.settings.editMode && this.settings.toggleEditModeOnClick;

        let tagClicked = false;
        let tagsContainerClicked = false;
        const classes = e.target.className.split(" ");
        for (let i = 0; i < classes.length && !(tagClicked && tagsContainerClicked); i++) {
            const c = classes[i];

            if (c === "tag" || c.includes("check")) {
                tagClicked = true;
            } else if (c === "tags") {
                tagsContainerClicked = true;
            }

        }
        if (this.state.editMode && this.settings.useDropDown) {
            this.toggleEditMode(false);
        } else {
            if (!tagClicked) {

                if (this.props.search) {
                    this.input.focus();
                }

                // End edit mode if user clicked outside a tag (and outside the
                // tags container, if the edit mode toggle button is visible)
                if (allowToggleEditMode && this.state.editMode
                    && !(this.settings.useEditModeButton && tagsContainerClicked)) {
                    this.toggleEditMode(false);
                }
                e.preventDefault();
            }

            if (allowToggleEditMode && !this.state.editMode) {
                this.toggleEditMode(true, {x: e.pageX, y: e.pageY});
                e.preventDefault();
            }
        }


    }

    handleClickOutside() {
        console.log("handleClickOutside; editMode: " + this.state.editMode);
        if (this.state.editMode && !this.settings.editMode) {
            console.log("Toggle edit mode to false");
            this.toggleEditMode(false);
        }
    }


    render() {

        const createNativeSelect = true;



        const renderNativeSelect = () => {

            const selectedValues = [];
            for (let i = 0; i < this.state.selectedIndices.length; i++) {
                const opt = this.options[this.state.selectedIndices[i]];
                if (opt != null && opt.value != null) {
                    selectedValues.push(opt.value);
                }
            }

            const selectStyle = {
            };

            if (!this.settings.native) {
                selectStyle.display = "none";
            }

            const optChildren = [];
            const options = this.options;

            // value string -> index map
            const valueStringToIndexMap = {};

            let optionsOffset = 0;

            // Add empty option:
            // optChildren.push(<option key={-1}/>);
            // optionsOffset++;

            for (let i = 0; i < options.length; i++) {
                const option = options[i];
                const selected = this.isOptionAtIndexSelected(i);
                valueStringToIndexMap[i] = '' + option.value;
                optChildren.push(
                    <option key={i} value={option.value}>{option.text}</option>
                );
            }

            return (
                <select className={"form-control"} multiple={this.props.multiple} style={selectStyle} value={selectedValues}
                    onChange={(e) => {

                        let selectedIndices = this.state.selectedIndices;

                        for (let i = 0; i < e.target.options.length; i++) {
                            if (i >= optionsOffset) {
                                const opt = e.target.options[i];
                                selectedIndices = this.setOptionAtIndexSelected(i - optionsOffset, opt.selected, selectedIndices);
                            }
                        }

                        //this.setOptionAtIndexSelected(valueStringToIndexMap[e.target.value], true);
                    }}>
                    {optChildren}
                </select>

            );
        };

        if (this.settings.native) {
            return renderNativeSelect();
        }

        const renderSearch = () => {
            return [(
                <input key={"searchTextInput"} className={""} type={"text"}
                       style={{
                           width: "0",
                           position: "absolute",
                           border: "0px none",
                           paddingLeft: "0.5em",
                           paddingRight: "0.5em"
                       }}
                       ref={(e) => {this.input = e;}}
                       value={this.state.text}
                       onChange={this.handleInputChange}/>
            ), (
                <span key={"fakeSearchText"} style={{
                    position: "fixed",
                    whiteSpace: "nowrap",
                    minWidth: "1em",
                    visibility: "hidden",
                    top: "-9999",
                    left:"-9999",
                }} ref={(e) => {this.fakeTextElem = e}}/>
            )];
        };

        const renderSelectOptions = (attrs) => {
            if (attrs == null) {
                attrs = {};
            }
            // Supported attrs:
            // addClassName
            // showUnselected
            // showCheckbox
            //
            const addClassName = (attrs.addClassName != null) ? attrs.addClassName : "";

            const showUnselected = attrs.showUnselected != null ? attrs.showUnselected : this.settings.showUnselected;
            const editMode = this.state.editMode;
            const useDropDown = this.settings.useDropDown;
            const showCheckbox = attrs.showCheckbox != null
                ? attrs.showCheckbox
                : ((editMode || (this.settings.showCheckboxesInViewMode && this.settings.showUnselected)) && !useDropDown);
            const itemLayout = (this.settings.itemLayout != null)
                ? this.settings.itemLayout : "";

            let className = "tag";

            if (addClassName.length > 0) {
                className += " " + addClassName;
            }

            if (itemLayout.length > 0) {
                className += " layout-" + this.settings.itemLayout;
            }

            const components = [];
            const options = this.options;
            const disabled = !this.state.editMode;
            const classNameSuffix = showCheckbox ? (disabled ? " disabled" : " edit-mode") : "";
            for (let i = 0; i < options.length; i++) {
                const option = options[i];
                const selected = this.isOptionAtIndexSelected(i);


                // Always show selected options
                // - Show unselected if showUnselected == true or
                //   in edit mode with useDropDown != true

                if (!(selected || showUnselected )) {
                    // Don't render this option
                    continue;
                }

                let thisTagNameSuffix = classNameSuffix + (selected ? " selected" : " unselected");

                //let thisInputNameSuffix = classNameSuffix;

                if (showCheckbox) {
                    thisTagNameSuffix += " with-checkbox";
                }
                const renderAsRadio = !this.props.multiple;
                const inputType = (renderAsRadio && this.settings.createRadioInputsForSingleSelection) ? "radio" : "checkbox";
                const inputClassName = renderAsRadio ? "radio" : "checkbox";

                const inputId = this.props.name + "_item[" + i + "]";
                const inputName = this.props.name;
                const inputValue = option.value;

                const renderCheckbox = () => {
                    return ([
                        (
                            <input key={"checkbox"}
                                   id={inputId}
                                   name={inputName}
                                   type={inputType}
                                   className={inputClassName}
                                   checked={selected}
                                   disabled={disabled}
                                   value={inputValue}
                                   onClick={(e) => { e.stopPropagation() }}
                                   onChange={(e) => {
                                       if (this.props.multiple) {
                                           this.setOptionAtIndexSelected(i, e.target.checked);
                                       } else {
                                           this.setOptionAtIndexSelected(i, true);
                                       }
                                   }}
                            />
                        ),(
                            <div key={"checkmark"} className={"checkmark " + inputClassName}>
                                <div className={"checkmark-inner "}/>
                            </div>
                        )
                    ]);
                };


                components.push(
                    <label key={i} className={className + thisTagNameSuffix} htmlFor={inputId}>
                        { showCheckbox && renderCheckbox() }
                        { option.text }
                    </label>
                );

            }
            return components;
        };



        const renderDropdown = () => {

            let popperPlacement = "bottom-start";
            const posHint = this.state.dropDownPositionHint;
            if (typeof posHint !== 'undefined' && posHint !== null) {
                if (posHint.fromToggleButton) {
                    popperPlacement = "bottom-end";
                }
            }

            return (
                <Popper reference={() => this.outerContainer}
                    className={"Popper"} placement={popperPlacement}>
                    <div className={"tags layout-vertical"}>
                        {renderSelectOptions({addClassName: "", showUnselected: true, showCheckbox: true})}
                    </div>
                </Popper>
            );

            // const style = {};
            //
            // const pos = this.state.dropDownPositionHint;
            // if (typeof pos !== 'undefined' && pos !== null) {
            //
            //     const localPos = CoordinateUtils.pageToElement(pos, this.outerContainer);
            //
            // }


        };

        const showToggleEditButton = !this.settings.editMode && this.settings.useEditModeButton;

        let className = "TagInput";

        let toggleButtonClassName = "btn btn-sm toggle-edit-mode";
        let toggleButtonText;
        if (this.state.editMode) {
            toggleButtonClassName += " btn-success toggle-edit-mode exit-edit-mode";
            toggleButtonText = "Ok";
        } else {
            toggleButtonClassName += " btn-secondary toggle-edit-mode enter-edit-mode";
            toggleButtonText = "...";
        }

        let optionsContainerClassName = "tags";
        if (typeof this.settings.itemsLayout !== 'undefined' && this.settings.itemsLayout !== null) {
            optionsContainerClassName += " layout-" + this.settings.itemsLayout;
        }
        if (showToggleEditButton) {
            optionsContainerClassName += " with-edit-button";
        }


        if (this.state.editMode) {
            className += " edit-mode";
        }

        const renderInnerContainer = () => {
            //
            const innerContainerClassName = "inner-container";
            const innerContainerStyle = {position: "relative"};


            return (
                <div className={innerContainerClassName} style={innerContainerStyle} ref={(e) => {this.innerContainer = e; }}>
                    { createNativeSelect && renderNativeSelect() }

                    <div className={optionsContainerClassName} style={{display: "inline-block"}} ref={(e) => {this.tagsContainer = e; }}>
                        {renderSelectOptions()}
                    </div>

                    { this.props.search && renderSearch() }

                    {
                        showToggleEditButton &&
                        <button className={toggleButtonClassName}
                                type={"button"}
                                onClick={this.handleToggleEditMode}>{toggleButtonText}</button>
                    }

                </div>
            );
        };



        return (

            <div className={className}>
                <div className={"form-control"} ref={(e) => { this.outerContainer = e; }} onClick={this.handleContainerClick}>
                    { renderInnerContainer() }
                </div>

                {
                    (this.state.editMode && this.settings.useDropDown) && renderDropdown()
                }

            </div>
        );



    }

    adjustSearchInputWidth() {

        if (!this.props.search) {
            return;
        }

        // Try to maintain minimum width of the input field
        // By default we will all the available space, i.e. space after tags container
        // If the calculated text width doesn't fit in to the available space, we
        // move the input field to the next line

        this.fakeTextElem.innerHTML = this.state.text;

        const containerWidth = this.innerContainer.offsetWidth;
        const tagsContainerWidth = this.tagsContainer.offsetWidth;
        const tagsContainerHeight = this.tagsContainer.offsetHeight;
        const tagsContainerTop = this.tagsContainer.offsetTop;
        const tagsContainerBottom = tagsContainerTop + tagsContainerHeight;

        const inputHeight = this.input.offsetHeight;



        // If tags inside tagsContainer are wrapped to multiple lines,
        // the container is using 100% width. We ned to find the actual
        // 'right' edge of the container, i.e. 'right' edge of a longest
        // tag (or the last tag, if 'alignInputAfterLastTag' is true):

        let longestTagRight = 0;

        if (this.settings.alignInputAfterLastTag) {
            const tags = this.tagsContainer.children;
            if (tags.length > 0) {
                const t = tags[tags.length - 1];
                longestTagRight = t.offsetLeft + t.offsetWidth;
            }
        } else {
            // Pick the
            for (let i = 0; i < this.tagsContainer.children.length; i++) {
                const t = this.tagsContainer.children[i];
                const tagRight = t.offsetLeft + t.offsetWidth;
                if (tagRight > longestTagRight) {
                    longestTagRight = tagRight;
                }
            }
        }

        let availableWidth = containerWidth - longestTagRight;

        const inputStyle = window.getComputedStyle(this.input, null);
        this.fakeTextElem.style['font'] = inputStyle['font'];
        this.fakeTextElem.style['padding'] = inputStyle['padding'];
        this.fakeTextElem.style['border'] = inputStyle['border'];

        let inputWidth = availableWidth;

        //let inputBottom = tagsContainerBottom;
        const absMinInputWidth = this.settings.absoluteMinInputWidth;
        const fakeTextWidth = this.fakeTextElem.offsetWidth;
        const minInputWidth = fakeTextWidth > absMinInputWidth ? fakeTextWidth : absMinInputWidth;

        let minContainerHeight = inputHeight > tagsContainerHeight ? inputHeight : tagsContainerHeight;

        if (availableWidth < minInputWidth && tagsContainerWidth > absMinInputWidth) {
            // Move input to next row after badges
            inputWidth = containerWidth;
            //inputTop = tagsContainerBottom;
            minContainerHeight += inputHeight;
            availableWidth = containerWidth;
        }

        if (inputWidth > availableWidth) {
            inputWidth = availableWidth;
        }

        this.input.style['width'] = inputWidth + "px";
        this.input.style['right'] = "0";
        this.input.style['bottom'] = "0px";

        // let minContainerHeight = inputBottom;
        if (minContainerHeight < tagsContainerBottom) {
            minContainerHeight = tagsContainerBottom;
        }

        this.innerContainer.style['height'] = minContainerHeight + "px";


    }

}

TagInput.propTypes = {
    multiple: PropTypes.bool,
    search: PropTypes.bool,
    name: PropTypes.string,

    settings: PropTypes.shape({

        // if true, all available options are shown, selected as checked
        // and unselected as unchecked
        showUnselected: PropTypes.bool,

        // If true, there will be a button to toggle the edit mode on / off
        useEditModeButton: PropTypes.bool,

        // If true, clicking on the component area will toggle between edit
        // and view modes.
        toggleEditModeOnClick: PropTypes.bool,

        // If true, the component is always in edit mode
        editMode: PropTypes.bool,

        // If true, options are selected from drop down / popup list. If false,
        // all options are always shown in the edit mode (regardless of the
        // 'showUnselected' value)
        useDropDown: PropTypes.bool,

        // Layout for options container: "flow" or "vertical"
        itemsLayout: PropTypes.oneOf(["flow", "vertical"]),

        // Layout for options: "badge" or "plain"
        itemLayout: PropTypes.oneOf(["badge", "plain"]),


        absoluteMinInputWidth: PropTypes.number,
        alignInputAfterLastTag: PropTypes.bool,
    }),



};

TagInput.defaultProps = {

    multiple: false,
    search: false,

    settings: {
        native: false,
        editMode: false,
        showUnselected: false,
        showCheckboxesInViewMode: true, // only if showUnselected: true
        useEditModeButton: true,
        toggleEditModeOnClick: null,
        useDropDown: true,
        itemsLayout: "vertical",
        itemLayout: "plain",
        createRadioInputsForSingleSelection: false,
        createNativeSelect: true,

        absoluteMinInputWidth: 20,
        alignInputAfterLastTag: true,

    }

};

TagInput.contextTypes = {

};


export default enhanceWithClickOutside(TagInput);
