jQuery(($)->
    shell = $('#shell')
    content = shell.find('[content]')
    output = shell.find('.output')
    readline = new ReadLine('#input')
    readline.sendCommand = (cmd)->
        $.get('/command', {cmd: cmd}).done (resp)->
            html = output.html()
            output.html( html + "\n"+ resp)
            content.scrollTop(output.height())
)

class ReadLine
    ENTER = 13
    UP = 38
    DOWN = 40
    constructor: (input)->
        @$el = jQuery(input)
        @history = [];
        @registListeners()
        @onKeyDown.bind @
        @onEnter.bind @
        @onUpOrDown.bind @
    registListeners: ()->
        @$el.on 'keyup', @onKeyDown.bind(@)
    onKeyDown: (event)->
        if event.which == ENTER
            @onEnter event
        else if event.which == UP or event.which == DOWN
            @onUpOrDown event
        else
            @current = @$el.val()

    onEnter: (event)->
        event.preventDefault()
        @history.push @current
        @sendCommand @current
        @current = ''
        @$el.val('')
    onUpOrDown: (event)->
        event.preventDefault()
        if not @historyCursor?
            @historyCursor = @history.length
        @historyCursor += if event.which == UP then -1 else 1
        @historyCursor = 0 if @historyCursor > @history.length
        @historyCursor = @history.length if @historyCursor < 0
        history = @history.slice()
        history.push @current
        @$el.val( history[ @historyCursor ] )




@.ReadLine = ReadLine
