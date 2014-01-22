# NOTICE : adapt this file and rename it to config.py
import logging

# the verbosity of the log, they are the standard python ones : DEBUG, INFO, ERROR ...
# Before reporting a problem, please try capture your logs with BOT_LOG_LEVEL = logging.DEBUG
BOT_LOG_LEVEL = logging.DEBUG

# set the log file, None = console only, be sure the user of the bot can write there
BOT_LOG_FILE = '/opt/logs/errbot.log'

# Enable logging to sentry (find out more about sentry at www.getsentry.com).
BOT_LOG_SENTRY = False
SENTRY_DSN = ''
SENTRY_LOGLEVEL = BOT_LOG_LEVEL

# Base configuration (Jabber mode)
#BOT_IDENTITY = {
#    'username' : 'err@localhost', # JID of the user you have created for the bot
#    'password' : 'changeme' # password of the bot user
#}

BOT_ASYNC = False # If true, the bot will handle the commands asynchronously [EXPERIMENTAL]

# HIPCHAT template
BOT_IDENTITY = {
    'username' : 'somenumber@chat.hipchat.com',
    'password' : 'somepass',
    'token' : 'hex-string'
}

BOT_ADMINS = ('somenumber@chat.hipchat.com',) # only those JIDs will have access to admin commands

BOT_DATA_DIR = '/opt/errbot/var' # Point this to a writeable directory by the system user running the bot
BOT_EXTRA_PLUGIN_DIR = '/opt/errbot/plugins' # Add this directory to the plugin discovery (useful to develop a new plugin locally)

# Prefix used for commands. Note that in help strings, you should still use the
# default '!'. If the prefix is changed from the default, the help strings will
# be automatically adjusted.
BOT_PREFIX = '!'

# ---- Chatrooms configuration (used by the chatroom plugin)
# it is a standard python file so you can reuse variables...
# For example: _TEST_ROOM = 'test@conference.localhost

_ROOM_ONE = 'room_id@conf.hipchat.com'
_ROOM_TWO = 'room_id2@conf.hipchat.com'

# CHATROOM_ PRESENCE
# it must be an iterable of names of rooms you want the bot to join at startup
# for example : CHATROOM_PRESENCE = (_TEST_ROOM,)
# for IRC you can name them with their # like #err_chatroom
CHATROOM_PRESENCE = (_ROOM_ONE,)

# CHATROOM_RELAY
# can be used to relay one to one message from specific users to the bot to MUCs
# it can be useful when XMPP notifiers like the standard Altassian Jira one doesn't support MUC
# for example : CHATROOM_RELAY = {'gbin@localhost' : (_TEST_ROOM,)}
CHATROOM_RELAY = {}

# REVERSE_CHATROOM_RELAY
# this feature forward whatever is said to a specific JID
# it can be useful if you client like gtalk doesn't support MUC correctly !
# for example REVERSE_CHATROOM_RELAY = {_TEST_ROOM : ('gbin@localhost',)}
REVERSE_CHATROOM_RELAY = {}

# CHATROOM_FN
# Some XMPP implementations like HipChat are super picky on the fullname you join with for a MUC
# If you use HipChat, make sure to exactly match the fullname you set for the bot user
CHATROOM_FN = 'Derpotron 2000'

# DIVERT_TO_PRIVATE
# An iterable of commands which should be responded to in private, even if the command was given
# in a MUC. For example: DIVERT_TO_PRIVATE = ('help', 'about', 'status')
DIVERT_TO_PRIVATE = ()

