{-# OPTIONS_GHC -fno-warn-deprecations #-}

module Network.Wai.Handler.Warp.Internal (
    -- * Settings
    Settings (..)
    -- * Low level run functions
  , runSettingsConnection
  , runSettingsConnectionMaker
  , runSettingsConnectionMakerSecure
  , Transport (..)
    -- * Connection
  , Connection (..)
  , socketConnection
    -- ** Buffer
  , Buffer
  , BufSize
  , bufferSize
  , allocateBuffer
  , freeBuffer
    -- ** Sendfile
  , FileId (..)
  , SendFile
  , sendFile
  , readSendFile
    -- * Version
  , warpVersion
    -- * Data types
  , InternalInfo (..)
  , HeaderValue
  , IndexedHeader
  , requestMaxIndex
    -- * Time out manager
    -- |
    --
    -- In order to provide slowloris protection, Warp provides timeout handlers. We
    -- follow these rules:
    --
    -- * A timeout is created when a connection is opened.
    --
    -- * When all request headers are read, the timeout is tickled.
    --
    -- * Every time at least 2048 bytes of the request body are read, the timeout
    --   is tickled.
    --
    -- * The timeout is paused while executing user code. This will apply to both
    --   the application itself, and a ResponseSource response. The timeout is
    --   resumed as soon as we return from user code.
    --
    -- * Every time data is successfully sent to the client, the timeout is tickled.
  , module Network.Wai.Handler.Warp.Timeout
    -- * File descriptor cache
  , module Network.Wai.Handler.Warp.FdCache
    -- * Date
  , module Network.Wai.Handler.Warp.Date
    -- * Request and response
  , Source
  , recvRequest
  , sendResponse
  ) where

import Control.Exception (SomeException)
import Network.Socket (SockAddr)
import Network.Wai (Request)
import Network.Wai.Handler.Warp.Buffer
import Network.Wai.Handler.Warp.Date
import Network.Wai.Handler.Warp.FdCache
import Network.Wai.Handler.Warp.Header
import Network.Wai.Handler.Warp.Request
import Network.Wai.Handler.Warp.Response
import Network.Wai.Handler.Warp.Run
import Network.Wai.Handler.Warp.SendFile
import Network.Wai.Handler.Warp.Settings
import Network.Wai.Handler.Warp.Timeout
import Network.Wai.Handler.Warp.Types
