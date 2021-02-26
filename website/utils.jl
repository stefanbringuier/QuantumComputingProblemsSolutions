using Franklin, JSON
using Markdown, Dates


const DATEFMT = dateformat"yyyy-mm-dd HH:MMp"
const TZ = "America/New_York"


function hfun_plutonotebookpage(params)
    path = params[1]
    path_to_html = if endswith(path, ".jl")
        path[1:end-3] * ".html"
    else
        path * ".html"
    end

    # https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Feature-Policy#directives

    return """
    <style>
    .content {
        max-width: 100%;
        margin-right: 0px;
        padding: 0px;
        overflow-y: hidden;
        height: 100vh;
    }
    .franklin-content {
        padding: 0px;
    }
    .page-foot {
        display: true;
    }
    .plutopage {
        height: 100vh;
    }
    .smallscreenlink {
        display: none;
    }
    @media (max-width: 768px) {
        .franklin-content {
            padding: 0px;
        }
    }

    </style>

    <iframe width="100%" height="100%"
    src="$(path_to_html)"
    class="plutopage"
    frameborder="0"
    allow="accelerometer; ambient-light-sensor; autoplay; battery; camera; display-capture; document-domain; encrypted-media; execution-while-not-rendered; execution-while-out-of-viewport; fullscreen; geolocation; gyroscope; layout-animations; legacy-image-formats; magnetometer; microphone; midi; navigation-override; oversized-images; payment; picture-in-picture; publickey-credentials-get; sync-xhr; usb; wake-lock; screen-wake-lock; vr; web-share; xr-spatial-tracking"
    allowfullscreen>
    </iframe>
    <a class="smallscreenlink" href="$(path_to_html)"></a>
    """
end
