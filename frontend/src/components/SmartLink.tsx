import { To, useNavigate } from "react-router-dom";

export function goto(path: string) {
    const navigate = useNavigate();
    navigate(path)
}

export default function SmartLink({ href, children }: { href: string, children?: any }) {
    const navigate = useNavigate();

    function handleClick(e: { preventDefault: () => void; target: { pathname: To; }; }) {
        e.preventDefault()
        navigate(e.target.pathname)
    }

    return <a onClick={e => handleClick(e)} href={href}>{ children }</a>
}