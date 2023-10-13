module.exports = function (grunt) {
    grunt.initConfig({
        shell: {
            startReactApp: {
                command: 'npm start',
                options: {
                    async: true, // Start CRA and continue with other tasks
                },
            },
            runSelenium: {
                command: 'npm test',
            },
        },
    });

    grunt.loadNpmTasks('grunt-shell');

    grunt.registerTask('startAndTest', ['shell:startReactApp', 'shell:runSelenium']);
};
