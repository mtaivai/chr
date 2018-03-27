
class PropertyUtils {

}

const _getOrSetValue = function(target, path, newValue) {

    const setValue = (typeof newValue !== 'undefined');

    const pathComponents = path.split('.');
    let val = target;
    for (let i = 0; i < pathComponents.length; i++) {

        const pn = pathComponents[i];

        const indexBeginPos = pn.indexOf('[');
        if (indexBeginPos > 0) {
            // indexed
            const indexEndPos = pn.indexOf(']', indexBeginPos);
            const index = pn.substring(indexBeginPos + 1, indexEndPos);
            const arrName = pn.substring(0, indexBeginPos);
            const arrObj = val[arrName];
            if (setValue && i === pathComponents.length - 1) {
                arrObj[index] = newValue;
            }
            val = arrObj[index];
        } else {
            if (setValue && i === pathComponents.length - 1) {
                val[pn] = newValue;
            }
            val = val[pn];
        }
    }

    return val;
};


PropertyUtils.getValue = function(target, path) {

    return _getOrSetValue(target, path, undefined);
};

PropertyUtils.setValue = function(target, path, value) {

    return _getOrSetValue(target, path, value);
};

export default PropertyUtils;

