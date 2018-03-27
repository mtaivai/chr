

class Highlighter  {

    /**
     * Returns:
     * {
     *   value: "Value with <strong>markup</strong>",
     *   text: "Text with <em>markup</em>...",
     *   ...
     * }
     *
     * @param searchResult
     * @param fields list of field names to include
     * @returns {*}
     */
    static createResultMarkup(searchResult, fields, className) {

        const item = searchResult.item;


        const markup = {
        };
        // Initialize with plain text:
        for (let i = 0; i < fields.length; i++) {
            markup[fields[i]] = item[fields[i]];
        }

        const includeField = (field) => {
            if (typeof field === 'undefined' || field === null) {
                return false;
            }
            for (let i = 0; i < fields.length; i++) {
                if (field === fields[i]) {
                    return true;
                }
            }
            return false;
        };

        const matches = searchResult.matches;

        let score = searchResult.score;
        if (typeof score === 'undefined' || score === null) {
            score = 0.5;
        }

        if (typeof matches !== 'undefined' && matches !== null) {


            for (let i = 0; i < matches.length; i++) {
                const match = matches[i];
                const f = match.key;
                if (!includeField(f)) {
                    continue;
                }
                const indices = match.indices;
                if (typeof indices === 'undefined' || indices === null) {
                    continue;
                }



                let plaintext = match.value;
                if (typeof plaintext === 'undefined' || plaintext === null) {
                    plaintext = item[f];
                }

                markup[f] = this.highlight(plaintext, indices, className, score);
            }

        }
        return markup;

    }
    static highlight(plaintext, indices, className, score) {
        if (typeof plaintext === 'undefined' || plaintext === null) {
            return "";
        }
        if (typeof className === 'undefined' || className === null) {
            className = "search-match-highlight";
        }



        let markup = "";
        let nextStart = 0;
        for (let i = 0; i < indices.length; i++) {
            const start = indices[i][0];
            const end = indices[i][1];

            const part = plaintext.substring(nextStart, start) +
                "<span class='" + className + "'>" +
                plaintext.substring(start, end + 1) +
                "</span>";

            markup += part;
            nextStart = end + 1;
        }
        if (nextStart < plaintext.length) {
            markup += plaintext.substring(nextStart);
        }
        markup += " " + score;
        return markup;
    }

}

export default Highlighter;